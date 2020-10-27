//
//  HeroDetailPresenter.swift
//  Project: HeroQ
//
//  Module: HeroDetail
//
//  Created by Tony Hadisiswanto on 27/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import SwiftyVIPER
import RxCocoa

// MARK: Protocols
protocol HeroDetailViewPresenterProtocol: ViewPresenterProtocol {
    // HeroDetail View to Presenter Protocol
    func getObsHero() -> BehaviorRelay<Hero>?
}

protocol HeroDetailInteractorPresenterProtocol: class {
    // HeroDetail Interactor to Presenter Protocol
    func set(title: String?)
    func performUpdates(animated: Bool)
}

// MARK: -

/// The Presenter for the HeroDetail module
final class HeroDetailPresenter {
    
    // MARK: - Constants
    let router: HeroDetailPresenterRouterProtocol
    let interactor: HeroDetailPresenterInteractorProtocol
    
    // MARK: Variables
    weak var view: HeroDetailPresenterViewProtocol?
    
    // MARK: Inits
    init(router: HeroDetailPresenterRouterProtocol, interactor: HeroDetailPresenterInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func viewLoaded() {
        interactor.requestTitle()
    }
}

extension HeroDetailPresenter: HeroDetailInteractorPresenterProtocol {
    
    // MARK: - HeroDetail Interactor to Presenter Protocol
    func set(title: String?) {
        view?.set(title: title)
    }
    
    func performUpdates(animated: Bool) {
        view?.performUpdates(animated: animated)
    }
}

extension HeroDetailPresenter: HeroDetailViewPresenterProtocol {
    
    // MARK: - HeroDetail View to Presenter Protocol
    func getObsHero() -> BehaviorRelay<Hero>? {
        return interactor.getObsHero()
    }
}
