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
import RxSwift

// MARK: Protocols
protocol HeroListViewPresenterProtocol: ViewPresenterProtocol {
    // HeroList View to Presenter Protocol
}

protocol HeroListInteractorPresenterProtocol: class {
    // HeroList Interactor to Presenter Protocol
    func set(title: String?)
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
}

extension HeroListPresenter: HeroListViewPresenterProtocol {
    
    // MARK: - HeroList View to Presenter Protocol
}
