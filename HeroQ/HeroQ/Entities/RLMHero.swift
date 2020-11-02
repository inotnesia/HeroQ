//
//  RLMHero.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 02/11/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import Foundation
import RealmSwift

class RLMHero: Object {
    @objc dynamic var id: Int = -1
    @objc dynamic var localizedName: String?
    @objc dynamic var attackType: String?
    var roles = List<String>()
    @objc dynamic var baseAttackMin: Int = -1
    @objc dynamic var baseAttackMax: Int = -1
    @objc dynamic var baseArmor: Float = 0.0
    @objc dynamic var moveSpeed: Int = -1
    @objc dynamic var baseHealth: Int = -1
    @objc dynamic var baseMana: Int = -1
    @objc dynamic var primaryAttr: String?
    @objc dynamic var img: String?
    
    convenience init(_ hero: Hero) {
        self.init()
        id = hero.id
        localizedName = hero.localizedName
        attackType = hero.attackType
        for role in hero.roles {
            roles.append(role)
        }
        baseAttackMin = hero.baseAttackMin
        baseAttackMax = hero.baseAttackMax
        baseArmor = hero.baseArmor
        moveSpeed = hero.moveSpeed
        baseHealth = hero.baseHealth
        baseMana = hero.baseMana
        primaryAttr = hero.primaryAttr
        img = hero.img
    }
}
