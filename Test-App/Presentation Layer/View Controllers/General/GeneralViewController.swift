//
//  GeneralViewController.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

class GeneralViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties -
    
    private lazy var dataSource: FeedDataSource = {
        return FeedDataSource()
    }()
    
    // MARK: - Life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRefreshControll()
        dataSource.addListener(self)
        dataSource.reloadData()
        signUpHeightConstraint.constant = CGFloat.scaleAccordingToDeviceSize(maximumSize: 45)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupClearNavigationBar()
    }
    
    // MARK: - IBAction
    
    @IBAction func signUpClicked(_ sender: Any) {
        showUserScreen(by: nil)
    }
    
    //MARK: - Private -

    private func setupRefreshControll() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refresh
        } else {
            tableView.addSubview(refresh)
        }
        
        reloadContent = { [unowned self] in
            self.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                // Put your code which should be executed with a delay here
                self.dataSource.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { [unowned self] in
                    self.refresh.endRefreshing()
                })
            })
        }
    }
    
    private func showUserScreen(by user: User?) {
        guard let vc: SignUpViewController = Storyboard.load(from: .signUp, with: .signUpView) else {
            assert(false, "Can't load SignUpViewController.")
            return
        }
        vc.user = user
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Delegates -

//MARK:  - UITableViewDataSource / UITableViewDelegate -

extension GeneralViewController: UITableViewDelegate, UITableViewDataSource  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItemsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GeneralCell.reuseIdentifier, for: indexPath) as? GeneralCell else {
            return UITableViewCell()
        }
        
        if let user = dataSource.itemAtIndexPath(indexPath) as? User {
            cell.user = user
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let user = dataSource.itemAtIndexPath(indexPath) as? User {
            showUserScreen(by: user)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - DataSourceDelegate -

extension GeneralViewController: DataSourceDelegate {
    
    func dataSourceWillLoadItems() {
        showActivityIndicator()
    }
    
    func dataSourceDidLoadItems(_ items: AnyObject) {
        tableView.reloadData()
        hideActivityIndicator()
    }
    
    func dataSourceDidLoadWithError(_ error: String) {
        hideActivityIndicator()
        showFailAlert(message: error, action: .notify)
    }
}

extension GeneralViewController: ActionDelegate {
    func reloadContent() {
        dataSource.reloadData()
    }
}
