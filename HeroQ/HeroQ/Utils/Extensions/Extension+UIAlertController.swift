//
//  Extension+UIAlertController.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 02/11/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import UIKit

extension UIAlertController {
    func addImage(_ image: UIImage) {
        let maxSize = CGSize(width: 245, height: 300)
        let imgSize = image.size
        
        var ratio: CGFloat!
        if (imgSize.width > imgSize.height) {
            ratio = maxSize.width / imgSize.width
        } else {
            ratio = maxSize.height / imgSize.height
        }
        
        let scaledSize = CGSize(width: imgSize.width * ratio, height: imgSize.height * ratio)
        let resizedImage = image.imageWithSize(scaledSize)
        
        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
        imgAction.setValue(resizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
        self.addAction(imgAction)
    }
}
