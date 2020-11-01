//
//  HQButton.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 28/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import UIKit

class HQButton: UIButton {
    
    override open var isSelected: Bool {
        didSet {
            stylize()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stylize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        stylize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stylize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stylize()
    }
    
    func stylize() {
        clipsToBounds = true
        backgroundColor = isSelected ? .heroQSecondaryColor : .white
        layer.cornerRadius = frame.height/2
        layer.borderColor = isSelected ? UIColor.clear.cgColor : UIColor.lightGray.cgColor
        layer.borderWidth = 2
        contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
        setTitleColor(.white, for: .selected)
        setTitleColor(.lightGray, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.textAlignment = .center
    }
}
