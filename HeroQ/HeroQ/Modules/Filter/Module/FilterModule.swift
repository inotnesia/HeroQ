//
//  FilterModule.swift
//  Project: HeroQ
//
//  Module: Filter
//
//  Created by Tony Hadisiswanto on 28/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import SwiftyVIPER
import RxCocoa

// MARK: -

/// Used to initialize the Filter VIPER module
final class FilterModule: ModuleProtocol {
    
    // MARK: - Variables
    private(set) lazy var interactor: FilterInteractor = {
        FilterInteractor()
    }()
    
    private(set) lazy var router: FilterRouter = {
        FilterRouter()
    }()
    
    private(set) lazy var presenter: FilterPresenter = {
        FilterPresenter(router: self.router, interactor: self.interactor)
    }()
    
    private(set) lazy var view: FilterViewController = {
        FilterViewController(presenter: self.presenter)
    }()
    
    // MARK: - Module Protocol Variables
    var viewController: UIViewController {
        return view
    }
    
    // MARK: Inits
    init(roles: [RoleFilter], delegate: FilterModuleProtocol?) {
        view.delegate = delegate
        presenter.view = view
        router.viewController = view
        interactor.presenter = presenter
        interactor.obsRoles.accept(roles)
    }
}
