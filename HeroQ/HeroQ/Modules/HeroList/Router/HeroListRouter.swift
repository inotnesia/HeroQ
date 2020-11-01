//
//  HeroListRouter.swift
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
protocol HeroListPresenterRouterProtocol: PresenterRouterProtocol {
    // HeroList Presenter to Router Protocol
    func goToHeroDetail(hero: Hero, similarHeroes: [Hero])
    func goToFilter(_ roles: [RoleFilter])
}

// MARK: -

/// The Router for the HeroList module
final class HeroListRouter: RouterProtocol {
    
    // MARK: - Variables
    weak var viewController: UIViewController?
}

extension HeroListRouter: HeroListPresenterRouterProtocol {
    
    // MARK: - HeroList Presenter to Router Protocol
    func goToHeroDetail(hero: Hero, similarHeroes: [Hero]) {
        HeroDetailModule(hero: hero, heroes: similarHeroes).push(from: viewController?.navigationController)
    }
    
    func goToFilter(_ roles: [RoleFilter]) {
        guard let view = viewController as? FilterModuleProtocol else { return }
        FilterModule(roles: roles, delegate: view).present(from: viewController, style: .coverVertical, isEmbedNavController: true)
    }
}
