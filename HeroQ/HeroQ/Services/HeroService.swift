//
//  HeroService.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 26/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import Foundation

class HeroService: HeroServiceProtocol {
    static let shared = HeroService()
    private init() {}
    let baseAPIURL = "https://api.opendota.com"
    private let _urlSession = URLSession.shared
    
    private let _jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    func fetchHeroes(successHandler: @escaping (_ response: [Hero]) -> Void, errorHandler: @escaping (_ error: Error) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/api/herostats") else {
            _handleError(errorHandler: errorHandler, error: HeroError.invalidEndpoint)
            return
        }
        
        _urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self._handleError(errorHandler: errorHandler, error: HeroError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self._handleError(errorHandler: errorHandler, error: HeroError.invalidResponse)
                return
            }
            
            guard let data = data else {
                self._handleError(errorHandler: errorHandler, error: HeroError.noData)
                return
            }
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            do {
                let heroResponse = try self._jsonDecoder.decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    successHandler(heroResponse)
                }
            } catch {
                self._handleError(errorHandler: errorHandler, error: HeroError.serializationError)
            }
        }.resume()
    }
    
    private func _handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            errorHandler(error)
        }
    }
}
