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
                let hero = Hero(rlmHero: rlmHero)
                heroes.append(hero)
            }
        } catch let error as NSError {
            print("Realm Error: \(error)")
        }
        return heroes
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
