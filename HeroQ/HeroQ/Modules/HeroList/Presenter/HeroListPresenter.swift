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
    func goToHeroDetail(_ hero: Hero)
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
    
    func goToHeroDetail(_ hero: Hero) {
        //TODO: implement navigation
        print("TODO: implement navigation")
    }
}
