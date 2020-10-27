//
//  HeroDetailModule.swift
//  Project: HeroQ
//
//  Module: HeroDetail
//
//  Created by Tony Hadisiswanto on 27/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import SwiftyVIPER

// MARK: -

/// Used to initialize the HeroDetail VIPER module
final class HeroDetailModule: ModuleProtocol {
    
    // MARK: - Variables
    private(set) lazy var interactor: HeroDetailInteractor = {
        HeroDetailInteractor()
    }()
    
    private(set) lazy var router: HeroDetailRouter = {
        HeroDetailRouter()
    }()
    
    private(set) lazy var presenter: HeroDetailPresenter = {
        HeroDetailPresenter(router: self.router, interactor: self.interactor)
    }()
    
    private(set) lazy var view: HeroDetailViewController = {
        HeroDetailViewController(presenter: self.presenter)
    }()
    
    // MARK: - Module Protocol Variables
    var viewController: UIViewController {
        return view
    }
    
    // MARK: Inits
    init(_ hero: Hero) {
        presenter.view = view
        router.viewController = view
        interactor.presenter = presenter
        interactor.obsHero?.accept(hero)
    }
}
