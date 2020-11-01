//
//  ButtonCollectionViewCell.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 28/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var button: HQButton!
    var view: FilterProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(index: Int, title: String, isSelected: Bool) {
        button.setTitle(title, for: .normal)
        button.isSelected = isSelected
        button.tag = index
    }
    
    @IBAction func buttonTapped(_ sender: HQButton) {
        sender.isSelected = !sender.isSelected
        view?.didRoleButtonTapped(index: sender.tag, isSelected: sender.isSelected)
    }
}
