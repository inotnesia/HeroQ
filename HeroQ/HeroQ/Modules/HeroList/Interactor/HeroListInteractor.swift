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
import RxCocoa
import RxSwift

// MARK: Protocols
protocol HeroListPresenterInteractorProtocol {
    // HeroList Presenter to Interactor Protocol
    func requestTitle()
    func fetchHeroes()
    func getObsHeroes() -> BehaviorRelay<[Hero]>
    func getFetchingState() -> Driver<Bool>
    func getErrorState() -> Bool
    func getErrorInfo() -> Driver<String?>
    func getSimilarHeroes(_ hero: Hero) -> [Hero]
    func getRoles() -> [RoleFilter]
    func filterHeroes(_ filters: [RoleFilter])
}

// MARK: -

/// The Interactor for the HeroList module
final class HeroListInteractor {
    
    // MARK: - Variables
    private let _disposeBag = DisposeBag()
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    weak var presenter: HeroListInteractorPresenterProtocol?
    lazy var obsHeroes: BehaviorRelay<[Hero]> = BehaviorRelay(value: [])
    private var _masterHeroes: [Hero] = []
    lazy var obsActiveFilters: BehaviorRelay<[RoleFilter]> = BehaviorRelay(value: [])
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    init() {
        setupObserver()
    }
    
    func setupObserver() {
        _ = obsHeroes.asObservable().subscribe({ (_) in
            self.presenter?.performUpdates(animated: true)
        }).disposed(by: _disposeBag)
    }
}

extension HeroListInteractor: HeroListPresenterInteractorProtocol {
    
    // MARK: - HeroList Presenter to Interactor Protocol
    func requestTitle() {
        presenter?.set(title: "Heroes")
    }
    
    func fetchHeroes() {
        if NetworkManager.shared.isConnectedToInternet() {
            HeroService.shared.fetchHeroes(successHandler: { [weak self] (response) in
                self?._isFetching.accept(false)
                self?.obsHeroes.accept(response)
                self?._masterHeroes = self?.obsHeroes.value ?? []
            }) { [weak self] (error) in
                self?._isFetching.accept(false)
                self?._error.accept(error.localizedDescription)
            }
        } else {
            presenter?.showNoInternetAlert()
        }
    }
    
    func getObsHeroes() -> BehaviorRelay<[Hero]> {
        return obsHeroes
    }
    
    func getFetchingState() -> Driver<Bool> {
        return isFetching
    }
    
    func getErrorState() -> Bool {
        return hasError
    }
    
    func getErrorInfo() -> Driver<String?> {
        return error
    }
    
    func getSimilarHeroes(_ hero: Hero) -> [Hero] {
        var arrHeroes = obsHeroes.value.filter {
                $0.id != hero.id &&
                $0.primaryAttr == hero.primaryAttr &&
                $0.roles.contains(hero.roles.first ?? "")
        }
        if hero.primaryAttr == "agi" {
            arrHeroes.sort { $0.moveSpeed > $1.moveSpeed }
        } else if hero.primaryAttr == "str" {
            arrHeroes.sort { $0.baseAttackMax > $1.baseAttackMax }
        } else {
            arrHeroes.sort { $0.baseMana > $1.baseMana }
        }
        return arrHeroes.count > 3 ? Array(arrHeroes.prefix(3)) : arrHeroes
    }
    
    func getRoles() -> [RoleFilter] {
        let allFilter = RoleFilter(id: 0, name: "All", isSelected: false)
        var filters: [RoleFilter] = [allFilter]
        
        for (indexA, hero) in _masterHeroes.enumerated() {
            var roles: [String] = []
            roles.append(contentsOf: hero.roles)
            for (indexB, role) in roles.enumerated() {
                let indexStr: String = "\(indexA+1)\(indexB)"
                let filter = RoleFilter(id: Int(indexStr) ?? -1, name: role, isSelected: false)
                filters.append(filter)
            }
        }
        filters = filters.unique { $0.name }
        filters.sort { $0.name < $1.name }
        
        // TODO: cek ini lagi bro, pake obs apa gak?
        if obsActiveFilters.value.count > 0 {
            for activeFilter in obsActiveFilters.value {
                for (index, filter) in filters.enumerated() where filter.name == activeFilter.name {
                    filters[index].isSelected = activeFilter.isSelected
                }
            }
        } else {
            filters[0].isSelected = true
        }
        
        return filters
    }
    
    func filterHeroes(_ filters: [RoleFilter]) {
        if filters.count > 0 {
            if let all = filters.first, all.id == 0, all.isSelected {
                obsHeroes.accept(_masterHeroes)
            } else {
                var result: [Hero] = []
                for role in filters {
                    let filtered = _masterHeroes.filter { $0.roles.contains(role.name) }
                    result.append(contentsOf: filtered)
                }
                result = result.unique { $0.id }
                obsHeroes.accept(result)
            }
        }
        obsActiveFilters.accept(filters)
    }
}
