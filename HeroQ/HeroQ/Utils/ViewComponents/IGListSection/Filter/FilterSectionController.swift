//
//  FilterSectionController.swift
//  Project: HeroQ
//
//  Created by Tony Hadisiswanto on 28/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import IGListKit
import RxCocoa

// MARK: Protocols
protocol FilterProtocol {
    func didRoleButtonTapped(index: Int, isSelected: Bool)
}

// MARK: - FilterSectionController
class FilterSectionController: ListSectionController {
    
    // MARK: - Constants
    
    // MARK: Variables
    private var identifier: FilterIdentifier?
    var view: FilterProtocol?
    
    convenience init(view: FilterProtocol?) {
        self.init()
        self.view = view
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionContext = collectionContext else { return CGSize.zero }
        return CGSize(width: collectionContext.containerSize.width, height: collectionContext.containerSize.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: String(describing: FilterCollectionViewCell.self), bundle: nil, for: self, at: index) as? FilterCollectionViewCell
            else { return UICollectionViewCell() }
        cell.identifier = identifier
        cell.view = view
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        identifier = object as? FilterIdentifier
    }
    
}

// MARK: - Filter
class FilterIdentifier: NSObject {
    
    // MARK: Variables
    var obsRoles: BehaviorRelay<[RoleFilter]>?
    
    init(_ roles: BehaviorRelay<[RoleFilter]>?) {
        self.obsRoles = roles
        super.init()
    }
    
    override func diffIdentifier() -> NSObjectProtocol {
        return self as NSObjectProtocol
    }
    
    override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? FilterIdentifier else { return false }
        return self === object
    }
}
