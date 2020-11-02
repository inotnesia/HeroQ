//
//  Hero.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 26/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import Foundation

struct Hero: Codable {
    let id: Int
    let localizedName: String
    let attackType: String
    let roles: [String]
    let baseAttackMin: Int
    let baseAttackMax: Int
    let baseArmor: Float
    let moveSpeed: Int
    let baseHealth: Int
    let baseMana: Int
    let primaryAttr: String
    let img: String
    var imageURL: URL {
        return URL(string: "\(HeroService.shared.baseAPIURL)\(img)")!
    }
    
    init(rlmHero: RLMHero) {
        self.id = rlmHero.id
        self.localizedName = rlmHero.localizedName ?? ""
        self.attackType = rlmHero.attackType ?? ""
        
        var roles: [String] = []
        for role in rlmHero.roles {
            roles.append(role)
        }
        self.roles = roles
        
        self.baseAttackMin = rlmHero.baseAttackMin
        self.baseAttackMax = rlmHero.baseAttackMax
        self.baseArmor = rlmHero.baseArmor
        self.moveSpeed = rlmHero.moveSpeed
        self.baseHealth = rlmHero.baseHealth
        self.baseMana = rlmHero.baseMana
        self.primaryAttr = rlmHero.primaryAttr ?? ""
        self.img = rlmHero.img ?? ""
    }
}
