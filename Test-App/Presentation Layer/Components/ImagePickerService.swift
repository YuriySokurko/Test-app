//
//  ImagePickerService.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

class ImagePickerService: NSObject,
                         UIImagePickerControllerDelegate,
                         UINavigationControllerDelegate {
    
    var galleryImagePicker = UIImagePickerController()
    var targetVC: UIViewController?
    internal var onImageSelected: ((_ image: UIImage) -> Void)?
    
    func showPickAttachment() {
        guard let target = targetVC else { return }
        
        let refreshAlert = UIAlertController(title: nil,
                                        message: nil,
                                 preferredStyle: .actionSheet)
        
        refreshAlert.addAction(UIAlertAction(title: "Choose from Camera Roll",
                                          style: .default,
                                        handler: { [weak self] _ in
                                            guard let `self` = self else { return }
                                            self.openGalleryPicker()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Take a Picture",
                                          style: .default,
                                        handler: { [weak self] _ in
                                            guard let `self` = self else { return }
                                            self.openCameraPicker()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        target.present(refreshAlert, animated: true)
    }
    
    func openCameraPicker() {
        guard let target = targetVC else { return }
        galleryImagePicker.delegate = self
        galleryImagePicker.sourceType = UIImagePickerController.SourceType.camera
        galleryImagePicker.allowsEditing = true
        target.present(galleryImagePicker, animated: true)
    }
    
    func openGalleryPicker() {
        guard let target = targetVC else { return }
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            galleryImagePicker.delegate = self
            galleryImagePicker.sourceType = .savedPhotosAlbum
            galleryImagePicker.allowsEditing = true
            target.present(galleryImagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: { [weak self] () -> Void in
            guard let `self` = self else { return }
            if let image = (info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage) {
                self.onImageSelected?(image)
            }
        })
    }
}
