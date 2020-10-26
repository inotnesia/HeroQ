//
//  HeroListModule.swift
//  Project: HeroQ
//
//  Module: HeroList
//
//  Created by Tony Hadisiswanto on 26/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import SwiftyVIPER

// MARK: -

/// Used to initialize the HeroList VIPER module
final class HeroListModule: ModuleProtocol {
    
    // MARK: - Variables
    private(set) lazy var interactor: HeroListInteractor = {
        HeroListInteractor()
    }()
    
    private(set) lazy var router: HeroListRouter = {
        HeroListRouter()
    }()
    
    private(set) lazy var presenter: HeroListPresenter = {
        HeroListPresenter(router: self.router, interactor: self.interactor)
    }()
    
    private(set) lazy var view: HeroListViewController = {
        HeroListViewController(presenter: self.presenter)
    }()
    
    // MARK: - Module Protocol Variables
    var viewController: UIViewController {
        return view
    }
    
    // MARK: Inits
    init() {
        presenter.view = view
        router.viewController = view
        interactor.presenter = presenter
    }
}
