//
//  FilterRouter.swift
//  Project: HeroQ
//
//  Module: Filter
//
//  Created by Tony Hadisiswanto on 28/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import SwiftyVIPER

// MARK: Protocols
protocol FilterPresenterRouterProtocol: PresenterRouterProtocol {
    // Filter Presenter to Router Protocol
}

// MARK: -

/// The Router for the Filter module
final class FilterRouter: RouterProtocol {
    
    // MARK: - Variables
    weak var viewController: UIViewController?
}

extension FilterRouter: FilterPresenterRouterProtocol {
    
    // MARK: - Filter Presenter to Router Protocol
}
