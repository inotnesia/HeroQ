//
//  Hero.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 26/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import Foundation

struct HeroResponse: Codable {
    let heroes: [Hero]
}

struct Hero: Codable {
    let id: Int
    let localizedName: String
    let attackType: String
    let roles: [String]
    let baseAttackMin: Int
    let baseAttackMax: Int
    let baseArmor: Int
    let moveSpeed: Int
    let baseHealth: Int
    let baseMana: Int
    let primaryAttr: String
    let img: String
    var imageURL: URL {
        //TODO: Revise this
        return URL(string: "\(HeroService.shared.baseAPIURL)\(img)")!
    }
}
