//
//  ImageCollectionViewCell.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 27/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(imageURL: URL, title: String) {
        imageView.kf.setImage(with: imageURL)
        imageView.clipsToBounds = true
        titleLabel.text = title
        layer.cornerRadius = 8
    }
}
