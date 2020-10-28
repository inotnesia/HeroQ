//
//  HeroDetailInteractor.swift
//  Project: HeroQ
//
//  Module: HeroDetail
//
//  Created by Tony Hadisiswanto on 27/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import Foundation
import SwiftyVIPER
import RxCocoa
import RxSwift

// MARK: Protocols
protocol HeroDetailPresenterInteractorProtocol {
    // HeroDetail Presenter to Interactor Protocol
    func requestTitle()
    func getObsHero() -> BehaviorRelay<Hero>?
    func getObsHeroes() -> BehaviorRelay<[Hero]>
}

// MARK: -

/// The Interactor for the HeroDetail module
final class HeroDetailInteractor {
    
    // MARK: - Variables
    private let _disposeBag = DisposeBag()
    weak var presenter: HeroDetailInteractorPresenterProtocol?
    var obsHero: BehaviorRelay<Hero>?
    lazy var obsHeroes: BehaviorRelay<[Hero]> = BehaviorRelay(value: [])
    
    init() {
        setupObserver()
    }
    
    func setupObserver() {
        _ = obsHero?.asObservable().subscribe({ (_) in
            self.presenter?.performUpdates(animated: true)
        }).disposed(by: _disposeBag)
        
        _ = obsHeroes.asObservable().subscribe({ (_) in
            self.presenter?.performUpdates(animated: true)
        }).disposed(by: _disposeBag)
    }
}

extension HeroDetailInteractor: HeroDetailPresenterInteractorProtocol {
    
    // MARK: - HeroDetail Presenter to Interactor Protocol
    func requestTitle() {
        presenter?.set(title: "Hero Detail")
        presenter?.performUpdates(animated: true)
    }
    
    func getObsHero() -> BehaviorRelay<Hero>? {
        return obsHero
    }
    
    func getObsHeroes() -> BehaviorRelay<[Hero]> {
        return obsHeroes
    }
}
