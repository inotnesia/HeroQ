//
//  FilterInteractor.swift
//  Project: HeroQ
//
//  Module: Filter
//
//  Created by Tony Hadisiswanto on 28/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import Foundation
import SwiftyVIPER
import RxCocoa
import RxSwift

// MARK: Protocols
protocol FilterPresenterInteractorProtocol {
    // Filter Presenter to Interactor Protocol
    func requestTitle()
    func getObsRoles() -> BehaviorRelay<[RoleFilter]>
    func didRoleButtonTapped(index: Int, isSelected: Bool)
    func getSelectedFilters() -> [RoleFilter]
}

// MARK: -

/// The Interactor for the Filter module
final class FilterInteractor {
    
    // MARK: - Variables
    private let _disposeBag = DisposeBag()
    weak var presenter: FilterInteractorPresenterProtocol?
    lazy var obsRoles: BehaviorRelay<[RoleFilter]> = BehaviorRelay(value: [])
    
    init() {
        setupObserver()
    }
    
    func setupObserver() {
        _ = obsRoles.asObservable().subscribe({ (_) in
            self.presenter?.performUpdates(animated: false)
        }).disposed(by: _disposeBag)
    }
}

extension FilterInteractor: FilterPresenterInteractorProtocol {
    
    // MARK: - Filter Presenter to Interactor Protocol
    func requestTitle() {
        presenter?.set(title: "Filter")
        presenter?.performUpdates(animated: true)
    }
    
    func getObsRoles() -> BehaviorRelay<[RoleFilter]> {
        return obsRoles
    }
    
    func didRoleButtonTapped(index: Int, isSelected: Bool) {
        var roles = obsRoles.value
        if roles.count > index {
            if index == 0 {
                for (idx, _) in roles.enumerated() {
                    roles[idx].isSelected = isSelected
                }
            } else {
                roles[index].isSelected = isSelected
                
                if let all = roles.first, all.isSelected {
                    roles[0].isSelected = false
                }
                
                let count = roles.filter { $0.isSelected == true }.count
                if count == (roles.count - 1) {
                    roles[0].isSelected = true
                }
            }
            obsRoles.accept(roles)
        }
    }
    
    func getSelectedFilters() -> [RoleFilter] {
        var filters: [RoleFilter] = []
        guard let all = obsRoles.value.first else { return filters }
        if all.isSelected {
            filters.append(all)
        } else {
            for role in obsRoles.value where role.isSelected == true {
                filters.append(role)
            }
        }
        return filters
    }
}
