//
//  HeroDetailRouter.swift
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
import RxSwift

// MARK: Protocols
protocol HeroDetailPresenterRouterProtocol: PresenterRouterProtocol {
    // HeroDetail Presenter to Router Protocol
    
}

// MARK: -

/// The Router for the HeroDetail module
final class HeroDetailRouter: RouterProtocol {
    
    // MARK: - Variables
    weak var viewController: UIViewController?
}

extension HeroDetailRouter: HeroDetailPresenterRouterProtocol {
    
    // MARK: - HeroDetail Presenter to Router Protocol
}
