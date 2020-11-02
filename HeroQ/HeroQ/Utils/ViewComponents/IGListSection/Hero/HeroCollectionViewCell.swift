//
//  HeroCollectionViewCell.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 27/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import UIKit
import Kingfisher

class HeroCollectionViewCell: UICollectionViewCell {
    
    var identifier: HeroIdentifier? {
        didSet {
            if let hero = identifier?.hero {
                setupView(hero)
            }
        }
    }
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    
    @IBOutlet weak var statsLabel: UILabel!
    
    @IBOutlet weak var attackImageView: UIImageView!
    @IBOutlet weak var attackLabel: UILabel!
    
    @IBOutlet weak var armorImageView: UIImageView!
    @IBOutlet weak var armorLabel: UILabel!
    
    @IBOutlet weak var speedImageView: UIImageView!
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var healthImageView: UIImageView!
    @IBOutlet weak var healthLabel: UILabel!
    
    @IBOutlet weak var manaImageView: UIImageView!
    @IBOutlet weak var manaLabel: UILabel!
    
    @IBOutlet weak var attributeImageView: UIImageView!
    @IBOutlet weak var attributeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(_ hero: Hero) {
        titleLabel.text = hero.localizedName
        titleLabel.textColor = .heroQPrimaryColor
        imageView.kf.setImage(with: hero.imageURL)
        imageView.layer.cornerRadius = 8
        roleLabel.text = hero.roles.joined(separator: " - ")
        roleLabel.textColor = .heroQPrimaryColor
        
        statsLabel.text = "Hero Stats"
        statsLabel.textColor = .heroQPrimaryColor
        
        attackImageView.image = UIImage(named: "sword")
        attackLabel.text = "\(hero.baseAttackMin) - \(hero.baseAttackMax)"
        attackLabel.textColor = .darkGray
        
        armorImageView.image = UIImage(named: "shield")
        armorLabel.text = "\(hero.baseArmor)"
        armorLabel.textColor = .darkGray
        
        speedImageView.image = UIImage(named: "boots")
        speedLabel.text = "\(hero.moveSpeed)"
        speedLabel.textColor = .darkGray
        
        healthImageView.image = UIImage(named: "hospital")
        healthLabel.text = "\(hero.baseHealth)"
        healthLabel.textColor = .darkGray
        
        manaImageView.image = UIImage(named: "tube")
        manaLabel.text = "\(hero.baseMana)"
        manaLabel.textColor = .darkGray
        
        attributeImageView.image = UIImage(named: "chain")
        attributeLabel.text = hero.primaryAttr
        attributeLabel.textColor = .darkGray
        
        cardView.layer.cornerRadius = 4
    }
}
