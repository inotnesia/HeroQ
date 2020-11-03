//
//  MockHeroListModule.swift
//  HeroQTests
//
//  Created by Tony Hadisiswanto on 03/11/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import Foundation
@testable import HeroQ

class MockHeroListModule {
    public static let shared = MockHeroListModule()
    private init() {}
    
    lazy var module: HeroListModule = {
        HeroListModule()
    }()
    
    lazy var interactor: HeroListInteractor = {
        HeroListInteractor()
    }()
    
    lazy var router: HeroListRouter = {
        HeroListRouter()
    }()
    
    lazy var presenter: HeroListPresenter = {
        HeroListPresenter(router: self.router, interactor: self.interactor)
    }()
    
    lazy var view: HeroListViewController = {
        HeroListViewController(presenter: self.presenter)
    }()
    
}
