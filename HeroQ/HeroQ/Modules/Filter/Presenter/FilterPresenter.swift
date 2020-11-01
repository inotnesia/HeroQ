//
//  FilterPresenter.swift
//  Project: HeroQ
//
//  Module: Filter
//
//  Created by Tony Hadisiswanto on 28/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import SwiftyVIPER
import RxCocoa

// MARK: Protocols
protocol FilterViewPresenterProtocol: ViewPresenterProtocol {
    // Filter View to Presenter Protocol
    func getObsRoles() -> BehaviorRelay<[RoleFilter]>
    func didRoleButtonTapped(index: Int, isSelected: Bool)
    func getSelectedFilters() -> [RoleFilter]
}

protocol FilterInteractorPresenterProtocol: class {
    // Filter Interactor to Presenter Protocol
    func set(title: String?)
    func performUpdates(animated: Bool)
}

// MARK: -

/// The Presenter for the Filter module
final class FilterPresenter {
    
    // MARK: - Constants
    let router: FilterPresenterRouterProtocol
    let interactor: FilterPresenterInteractorProtocol
    
    // MARK: Variables
    weak var view: FilterPresenterViewProtocol?
    
    // MARK: Inits
    init(router: FilterPresenterRouterProtocol, interactor: FilterPresenterInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func viewLoaded() {
        interactor.requestTitle()
    }
}

extension FilterPresenter: FilterInteractorPresenterProtocol {
    
    // MARK: - Filter Interactor to Presenter Protocol
    func set(title: String?) {
        view?.set(title: title)
    }
    
    func performUpdates(animated: Bool) {
        view?.performUpdates(animated: animated)
    }
}

extension FilterPresenter: FilterViewPresenterProtocol {
    
    // MARK: - Filter View to Presenter Protocol
    func getObsRoles() -> BehaviorRelay<[RoleFilter]> {
        return interactor.getObsRoles()
    }
    
    func didRoleButtonTapped(index: Int, isSelected: Bool) {
        interactor.didRoleButtonTapped(index: index, isSelected: isSelected)
    }
    
    func getSelectedFilters() -> [RoleFilter] {
        return interactor.getSelectedFilters()
    }
}
