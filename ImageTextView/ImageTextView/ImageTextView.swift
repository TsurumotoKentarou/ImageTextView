//
//  ImageTextView.swift
//  ImageTextView
//
//  Created by 鶴本賢太朗 on 2019/05/31.
//  Copyright © 2019 Kentarou. All rights reserved.
//

import UIKit

protocol ImageTextViewDelegate: class {
    func didTapImage()
}

class ImageTextView: UITextView {
    
    internal weak var imageDelegate: ImageTextViewDelegate?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.initToolBar()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initToolBar()
    }
    @objc private func didTapDone() {
        self.resignFirstResponder()
    }
    @objc private func didTapImage() {
        self.imageDelegate?.didTapImage()
    }
    @objc private func didTapCancel() {
        self.resignFirstResponder()
    }
}

extension ImageTextView {
    private func initToolBar() {
        self.textContainer.lineFragmentPadding = 0
        
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        // 真ん中のスペース
        let space: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        // キャンセルボタン
        let cancel: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapCancel))
        // 画像
        let image: UIBarButtonItem = UIBarButtonItem(title: "画像", style: .plain, target: self, action: #selector(self.didTapImage))
        // 完了ボタン
        let done: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.didTapDone))
        toolBar.setItems([cancel, image, space, done], animated: true)
        self.inputAccessoryView = toolBar
    }
    internal func addImage(image: UIImage) {
        //画像
        let attachment = NSTextAttachment()
        attachment.image = image
        let left: CGFloat = self.textContainerInset.left
        let right: CGFloat = self.textContainerInset.right
        let width: CGFloat = self.frame.width - (left + right)
        let height: CGFloat = width * (image.size.height / image.size.width)
        attachment.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        let strImage = NSAttributedString(attachment: attachment)
        
        let str = NSMutableAttributedString(attributedString: self.attributedText)
        str.append(strImage)
        //セットする
        self.attributedText = str
        self.font = UIFont.systemFont(ofSize: 22)
    }
}
