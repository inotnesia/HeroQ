//
//  MockHeroes.swift
//  HeroQTests
//
//  Created by Tony Hadisiswanto on 03/11/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import Foundation
@testable import HeroQ

class MockHeroes {
    public static let shared = MockHeroes()
    private init() {}
    
    private let _jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    func getMockHeroesResponse() throws -> [Hero] {
        guard let path = Bundle.main.path(forResource: "heroesresponse", ofType: "json") else {
            fatalError("Can't find heroesresponse.json file")
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let response = try self._jsonDecoder.decode([Hero].self, from: data)
        return response
    }
    
    func getMockHero() throws -> Hero? {
        let response = try getMockHeroesResponse()
        return response.first
    }
}
