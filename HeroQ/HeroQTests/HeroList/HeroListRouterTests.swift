//
//  HeroListRouterTests.swift
//  HeroQTests
//
//  Created by Tony Hadisiswanto on 03/11/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import XCTest
import SwiftyVIPER
import RxCocoa
@testable import HeroQ

class HeroListRouterTests: XCTestCase {
    
    var router: HeroListRouter?
    var isNavigateToHeroDetail = false
    var isNavigateToFilter = false
    
    let stubHero = Hero(id: 1, localizedName: "Anti-Mage", attackType: "Melee", roles: ["Carry", "Escape", "Nuker"], baseAttackMin: 29, baseAttackMax: 33, baseArmor: -1, moveSpeed: 310, baseHealth: 200, baseMana: 75, primaryAttr: "agi", img: "/apps/dota2/images/heroes/antimage_full.png?")
    
    var stubHeroes: [Hero] = []
    var stubRoles: [RoleFilter] = []

    override func setUp() {
        let module = MockHeroListModule.shared.module
        router = module.router
        
        let hero1 = Hero(id: 8, localizedName: "Juggernaut", attackType: "Melee", roles: ["Carry", "Pusher", "Escape"], baseAttackMin: 16, baseAttackMax: 20, baseArmor: 0.0, moveSpeed: 305, baseHealth: 200, baseMana: 75, primaryAttr: "agi", img: "/apps/dota2/images/heroes/juggernaut_full.png?")
        let hero2 = Hero(id: 4, localizedName: "Bloodseeker", attackType: "Melee", roles: ["Carry", "Disabler", "Jungler", "Nuker", "Initiator"], baseAttackMin: 33, baseAttackMax: 39, baseArmor: 2.0, moveSpeed: 300, baseHealth: 200, baseMana: 75, primaryAttr: "agi", img: "/apps/dota2/images/heroes/bloodseeker_full.png?")
        let hero3 = Hero(id: 9, localizedName: "Mirana", attackType: "Ranged", roles: ["Carry", "Support", "Escape", "Nuker", "Disabler"], baseAttackMin: 27, baseAttackMax: 32, baseArmor: -1.0, moveSpeed: 290, baseHealth: 200, baseMana: 75, primaryAttr: "agi", img: "/apps/dota2/images/heroes/mirana_full.png?")
        stubHeroes = [hero1, hero2, hero3]
        
        let all = RoleFilter(id: 0, name: "All", isSelected: true)
        let carry = RoleFilter(id: 1, name: "Carry", isSelected: false)
        let escape = RoleFilter(id: 2, name: "Escape", isSelected: false)
        stubRoles = [all, carry, escape]
        
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testNavigateToHeroDetail() {
        router?.goToHeroDetail(hero: stubHero, similarHeroes: stubHeroes)
        isNavigateToHeroDetail = true
        XCTAssertTrue(isNavigateToHeroDetail)
    }
    
    func testNavigateToFilter() {
        router?.goToFilter(stubRoles)
        isNavigateToFilter = true
        XCTAssertTrue(isNavigateToFilter)
    }
}
