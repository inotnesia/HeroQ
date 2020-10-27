//
//  HeroListAdapter.swift
//  Project: HeroQ
//
//  Module: HeroList
//
//  Created by Tony Hadisiswanto on 26/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import IGListKit
import RxCocoa

// MARK: -

/// The Adapter for the HeroList module
class HeroListAdapter: ListAdapter {
    
    // MARK: - Constants
    
    // MARK: Variables
    var listDiffable: [ListDiffable] = []
    var obsHeroes: BehaviorRelay<[Hero]>?
    
    // MARK: Inits
    init(viewController: UIViewController?) {
        super.init(updater: ListAdapterUpdater(), viewController: viewController, workingRangeSize: 0)
        self.setupListDiffable()
        self.dataSource = self
    }
    
    // MARK: - Custom Functions
    func setupListDiffable() {
        var list: [ListDiffable] = []
        
        if obsHeroes?.value.count ?? 0 > 0 {
            list.append(GridIdentifier(heroes: obsHeroes?.value ?? []))
        }
        //list.append(EmptyIdentifier(height: 4))
        
        listDiffable = list
    }
    
    override func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return listDiffable
    }
    
    override func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
