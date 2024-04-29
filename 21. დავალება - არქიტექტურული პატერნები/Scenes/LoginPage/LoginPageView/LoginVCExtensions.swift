//
//  LoginVCExtensions.swift
//  22. დავალება - Data Persistence
//
//  Created by gvantsa gvagvalia on 4/27/24.
//

import Foundation
import UIKit

extension LoginVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            let imageSize = imageButon.bounds.size
            let roundedImage = image.roundedImage(size: imageSize)
            imageButon.setBackgroundImage(roundedImage, for: .normal)
            if let fileURL = FileManagerServise.shared.saveImageToDocumentsDirectory(image: image) {
            }
        }
    }
}

extension UIImage {
    func roundedImage(size: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        UIBezierPath(roundedRect: rect, cornerRadius: size.width).addClip()
        self.draw(in: rect)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage ?? self
    }
}
