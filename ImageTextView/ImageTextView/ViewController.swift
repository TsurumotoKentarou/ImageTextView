//
//  ViewController.swift
//  ImageTextView
//
//  Created by 鶴本賢太朗 on 2019/05/31.
//  Copyright © 2019 Kentarou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageTextView: ImageTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageTextView.imageDelegate = self
    }
}

extension ViewController {
    private func showImagePicker() {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}

extension ViewController: ImageTextViewDelegate {
    func didTapImage() {
        self.showImagePicker()
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            guard let image: UIImage = info[.originalImage] as? UIImage else { return }
            guard let resizeImage: UIImage = image.resize(length: 300) else { return }
            self.imageTextView.addImage(image: resizeImage)
        }
    }
}

extension UIImage {
    internal func resize(length: CGFloat) -> UIImage? {
        var width: CGFloat
        var height: CGFloat
        if self.isLongWidth {
            width = length
            height = width * (self.size.height / self.size.width)
        }
        else {
            height = length
            width = height * (self.size.width / self.size.height)
        }
        let newResizedSize: CGSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(newResizedSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: newResizedSize))
        let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    internal var isLongWidth: Bool {
        return self.size.width > self.size.height
    }
}
