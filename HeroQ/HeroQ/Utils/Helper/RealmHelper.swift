//
//  RealmHelper.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 02/11/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    static let shared = RealmHelper()
    private init() {}
    
    func saveHeroes(_ heroes: [Hero]) {
        do {
            let realm = try Realm(configuration: RealmHelper.config)
            for hero in heroes {
                let rlmHero = RLMHero(hero)
                try realm.write {
                    realm.add(rlmHero)
                }
            }
        } catch let error as NSError {
            print("Realm Error: \(error)")
        }
    }
    
    func getHeroes() -> [Hero] {
        var heroes: [Hero] = []
        do {
            let realm = try Realm(configuration: RealmHelper.config)
            for rlmHero in realm.objects(RLMHero.self) {
                let hero = _setHero(rlmHero)
                heroes.append(hero)
            }
        } catch let error as NSError {
            print("Realm Error: \(error)")
        }
        return heroes
    }
    
    private func _setHero(_ rlmHero: RLMHero) -> Hero {
        var roles: [String] = []
        for role in rlmHero.roles {
            roles.append(role)
        }
        return Hero(id: rlmHero.id, localizedName: rlmHero.localizedName ?? "", attackType: rlmHero.attackType ?? "", roles: roles, baseAttackMin: rlmHero.baseAttackMin, baseAttackMax: rlmHero.baseAttackMax, baseArmor: rlmHero.baseArmor, moveSpeed: rlmHero.moveSpeed, baseHealth: rlmHero.baseHealth, baseMana: rlmHero.baseMana, primaryAttr: rlmHero.primaryAttr ?? "", img: rlmHero.img ?? "")
    }
    
    static let config = Realm.Configuration(
        schemaVersion: 0,
        migrationBlock: { _, oldSchemaVersion in
            // We haven’t migrated anything yet, so oldSchemaVersion == 0
            if (oldSchemaVersion < 0) {
                // Nothing to do!
            }
    })
}
