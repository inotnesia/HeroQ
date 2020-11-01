//
//  HeroListPresenter.swift
//  Project: HeroQ
//
//  Module: HeroList
//
//  Created by Tony Hadisiswanto on 26/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import SwiftyVIPER
import RxCocoa

// MARK: Protocols
protocol HeroListViewPresenterProtocol: ViewPresenterProtocol {
    // HeroList View to Presenter Protocol
    func getObsHeroes() -> BehaviorRelay<[Hero]>
    func getFetchingState() -> Driver<Bool>
    func getErrorState() -> Bool
    func getErrorInfo() -> Driver<String?>
    func getSimilarHeroes(_ hero: Hero) -> [Hero]
    func goToHeroDetail(hero: Hero, similarHeroes: [Hero])
    func goToFilter(_ roles: [RoleFilter])
    func getRoles() -> [RoleFilter]
    func filterHeroes(_ filters: [RoleFilter])
}

protocol HeroListInteractorPresenterProtocol: class {
    // HeroList Interactor to Presenter Protocol
    func set(title: String?)
    func performUpdates(animated: Bool)
}

// MARK: -

/// The Presenter for the HeroList module
final class HeroListPresenter {
    
    // MARK: - Constants
    let router: HeroListPresenterRouterProtocol
    let interactor: HeroListPresenterInteractorProtocol
    
    // MARK: Variables
    weak var view: HeroListPresenterViewProtocol?
    
    // MARK: Inits
    init(router: HeroListPresenterRouterProtocol, interactor: HeroListPresenterInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func viewLoaded() {
        interactor.requestTitle()
        interactor.fetchHeroes()
    }
}

extension HeroListPresenter: HeroListInteractorPresenterProtocol {
    
    // MARK: - HeroList Interactor to Presenter Protocol
    func set(title: String?) {
        view?.set(title: title)
    }
    
    func performUpdates(animated: Bool) {
        view?.performUpdates(animated: animated)
    }
}

extension HeroListPresenter: HeroListViewPresenterProtocol {
    
    // MARK: - HeroList View to Presenter Protocol
    func getObsHeroes() -> BehaviorRelay<[Hero]> {
        return interactor.getObsHeroes()
    }
    
    func getFetchingState() -> Driver<Bool> {
        return interactor.getFetchingState()
    }
    
    func getErrorState() -> Bool {
        return interactor.getErrorState()
    }
    
    func getErrorInfo() -> Driver<String?> {
        return interactor.getErrorInfo()
    }
    
    func getSimilarHeroes(_ hero: Hero) -> [Hero] {
        return interactor.getSimilarHeroes(hero)
    }
    
    func goToHeroDetail(hero: Hero, similarHeroes: [Hero]) {
        router.goToHeroDetail(hero: hero, similarHeroes: similarHeroes)
    }
    
    func goToFilter(_ roles: [RoleFilter]) {
        router.goToFilter(roles)
    }
    
    func getRoles() -> [RoleFilter] {
        return interactor.getRoles()
    }
    
    func filterHeroes(_ filters: [RoleFilter]) {
        interactor.filterHeroes(filters)
    }
}
