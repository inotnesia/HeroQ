//
//  HeroDetailAdapter.swift
//  Project: HeroQ
//
//  Module: HeroDetail
//
//  Created by Tony Hadisiswanto on 27/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import IGListKit
import RxCocoa

// MARK: -

/// The Adapter for the HeroDetail module
class HeroDetailAdapter: ListAdapter {
    
    // MARK: Variables
    var listDiffable: [ListDiffable] = []
    var obsHero: BehaviorRelay<Hero>?
    
    // MARK: Inits
    init(viewController: UIViewController?) {
        super.init(updater: ListAdapterUpdater(), viewController: viewController, workingRangeSize: 0)
        self.setupListDiffable()
        self.dataSource = self
    }
    
    // MARK: - Custom Functions
    func setupListDiffable() {
        var list: [ListDiffable] = []
        
        // Add ListDiffable here
        list.append(EmptyIdentifier(height: 4))
        
        listDiffable = list
    }
    
    override func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return listDiffable
    }
    
    override func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
