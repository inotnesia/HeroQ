//
//  HeroListInteractor.swift
//  Project: HeroQ
//
//  Module: HeroList
//
//  Created by Tony Hadisiswanto on 26/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import Foundation
import SwiftyVIPER
import RxSwift

// MARK: Protocols
protocol HeroListPresenterInteractorProtocol {
    // HeroList Presenter to Interactor Protocol
    func requestTitle()
    func fetchHeroes()
}

// MARK: -

/// The Interactor for the HeroList module
final class HeroListInteractor {
    
    // MARK: - Variables
    private let disposeBag = DisposeBag()
    weak var presenter: HeroListInteractorPresenterProtocol?
    
    init() {
        setupObserver()
    }
    
    func setupObserver() {
//        _ = paramsChangePassword.asObservable().subscribe(onNext: { (newValue) in
//            // update value
//            print(newValue)
//        }).disposed(by: disposeBag)
    }
}

extension HeroListInteractor: HeroListPresenterInteractorProtocol {
    
    // MARK: - HeroList Presenter to Interactor Protocol
    func requestTitle() {
        presenter?.set(title: "HeroList")
    }
    
    func fetchHeroes() {
        HeroService.shared.fetchHeroes(successHandler: { [weak self] (response) in
            print("## success")
            print(response)
//            self?._isFetching.accept(false)
//            self?.obsMovies.accept(response.results)
        }) { [weak self] (error) in
            print(error)
//            self?._isFetching.accept(false)
//            self?._error.accept(error.localizedDescription)
        }
    }
}
