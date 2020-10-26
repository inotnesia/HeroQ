//
//  HeroServiceProtocol.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 26/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import Foundation

protocol HeroServiceProtocol {
    func fetchHeroes(successHandler: @escaping (_ response: HeroResponse) -> Void, errorHandler: @escaping (_ error: Error) -> Void)
}

enum HeroError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
