//
//  MockHeroServiceProtocol.swift
//  HeroQTests
//
//  Created by Tony Hadisiswanto on 03/11/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import Foundation
@testable import HeroQ

class MockHeroServiceProtocol: HeroServiceProtocol {
    
    var isFetchHeroesInvoked = false
    
    func fetchHeroes(successHandler: @escaping (_ response: [Hero]) -> Void, errorHandler: @escaping (_ error: Error) -> Void) {
        isFetchHeroesInvoked = true
        do {
            let response = try MockHeroes.shared.getMockHeroesResponse()
            successHandler(response)
        } catch {
            self._handleError(errorHandler: errorHandler, error: HeroError.serializationError)
        }
    }
    
    private func _handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            errorHandler(error)
        }
    }
}
