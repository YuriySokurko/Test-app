//
//  SignUpViewController.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/16/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift

class SignUpViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var errorBackgroundViews: [UIView]!
    @IBOutlet weak var pencilContainerView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var pencilImageView: UIImageView!
    @IBOutlet weak var fieldsStackView: UIStackView!
    @IBOutlet weak var saveButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstTextField: TextFieldValidator!
    @IBOutlet weak var lastTextField: TextFieldValidator!
    @IBOutlet weak var emailTextField: TextFieldValidator!
    
    //MARK: - Properties -
    
    var user: User?
    var delegate: ActionDelegate?
    private var mediaPicker = ImagePickerService()
    private var iconImage: UIImage?
    
    // MARK: - Life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageAction()
        scaleViewItems()
        configureFieldsValidation()
        configureMediaPicker()
        
        if let _ = user {
            fillScreenByUser()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupClearNavigationBar()
        configurationKeyboardNotification()
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses = [UIStackView.self, UIView.self]
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        removeObserver()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userImageView.layer.cornerRadius = userImageView.frame.size.height/2
        pencilContainerView.layer.cornerRadius = pencilContainerView.frame.size.height/2
    }
    
    // MARK: - IBAction
    
    @IBAction func backButtonClicked(_ sender: Any) {
        openPreviousScreen()
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let validations: [Bool] = [firstTextField.validate(), lastTextField.validate(), emailTextField.validate()]
        
        if !validations.contains(false) {
            if let updtUser = user {
                if updtUser.firstName == firstTextField.text && updtUser.lastName == lastTextField.text && updtUser.email == emailTextField.text && iconImage == nil {
                    showFailAlert(message: "Change user for update!", action: .notify)
                } else {
                    guard let userId = user?.userId else { return }
                    let model = p2pModel(user: User(firstName: firstTextField.text ?? "",
                                                    lastName: lastTextField.text ?? "",
                                                       email: emailTextField.text ?? "",
                                                          id: userId),
                                                       image: iconImage)
                    let request = UpdateUserRequest(withModel: model)
                    showActivityIndicator()
                    request.resumeWithCompletionClosure { result in
                        self.hideActivityIndicator()
                        if let error = result.hasAlertMessage() {
                            self.showFailAlert(message: error, action: .notify)
                        } else {
                            self.showSuccessAlert(message: "User updated!", action: .notify_with(handler: {
                                self.delegate?.reloadContent()
                                self.openPreviousScreen()
                            }))
                        }
                    }
                }
            } else {
                if let first = firstTextField.text, let last = lastTextField.text,
                    let email = emailTextField.text {
                    let model = p2pModel(user: User(firstName: first,
                                                    lastName: last,
                                                       email: email,
                                                          id: ""), image: iconImage)
                    let request = CreateUsersRequest(withModel: model)
                    showActivityIndicator()
                    request.resumeWithCompletionClosure { result in
                        self.hideActivityIndicator()
                        if let error = result.hasAlertMessage() {
                            self.showFailAlert(message: error, action: .notify)
                        } else {
                            self.updateBySuccess()
                            self.showSuccessAlert(message: "User created!", action: .notify)
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Private -
    
    private func fillScreenByUser() {
        firstTextField.text = user?.firstName
        lastTextField.text  = user?.lastName
        emailTextField.text = user?.email
        userImageView.sd_setImage(with: user?.imageUrl,
                   placeholderImage: UIImage(named: "avatar-placeholder"))
    }

    private func updateBySuccess() {
        userImageView.image = UIImage(named: "avatar-placeholder")
        firstTextField.text?.removeAll()
        lastTextField.text?.removeAll()
        emailTextField.text?.removeAll()
        iconImage = nil
    }
    
    private func scaleViewItems() {
        saveButtonHeightConstraint.constant = CGFloat.scaleAccordingToDeviceSize(maximumSize: 45)
        fieldsStackView.spacing = CGFloat.scaleAccordingToDeviceSize(maximumSize: 20)
        
        let imageName = user?.imageUrl == nil ? "plus" : "pencil"
        pencilImageView.image = UIImage(named: imageName)
        pencilImageView.image = UIImage.coloredImage(imageName: imageName, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    private func configureFieldsValidation() {
        firstTextField.addRegx(Constant.NAME_REGX, withMsg: Constant.NAME_DESCRIPTION_ERROR)
        firstTextField.backgroundView = errorBackgroundViews[0]
        lastTextField.addRegx(Constant.NAME_REGX, withMsg: Constant.NAME_DESCRIPTION_ERROR)
        lastTextField.backgroundView = errorBackgroundViews[1]
        emailTextField.addRegx(Constant.EMAIL_REGX, withMsg: Constant.EMAIL_DESCRIPTION_ERROR)
        emailTextField.backgroundView = errorBackgroundViews[2]
    }
    
    private func setupImageAction() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        userImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func configureMediaPicker() {
        mediaPicker.targetVC = self
        mediaPicker.onImageSelected = { [weak self] image in
            guard let `self` = self else { return }
            self.userImageView.image = image
            self.iconImage = image
        }
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        mediaPicker.showPickAttachment()
    }
}

// MARK: - Keyboard Notifications -

extension SignUpViewController {
    @objc override func keyboardWillShow(notification: NSNotification) {
        scrollView.isScrollEnabled = true
    }
    
    @objc override func keyboardWillHide(notification: NSNotification) {
        scrollView.isScrollEnabled = false
    }
}
