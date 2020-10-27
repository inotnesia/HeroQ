//
//  GridSectionController.swift
//  Project: HeroQ
//
//  Created by Tony Hadisiswanto on 27/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import IGListKit

// MARK: Protocols
protocol GridProtocol {
    func didHeroTapped(_ hero: Hero)
}

// MARK: - GridSectionController
class GridSectionController: ListSectionController {
    
    // MARK: - Constants
    
    // MARK: Variables
    private var identifier: GridIdentifier?
    var view: GridProtocol?
    
    convenience init(view: GridProtocol?) {
        self.init()
        self.view = view
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionContext = collectionContext else { return CGSize.zero }
        return CGSize(width: collectionContext.containerSize.width, height: collectionContext.containerSize.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: String(describing: GridCollectionViewCell.self), bundle: nil, for: self, at: index) as? GridCollectionViewCell
            else { return UICollectionViewCell() }
        cell.items = identifier?.heroes
        cell.view = view
        return cell
    }
    
    override func didUpdate(to object: Any) {
        identifier = object as? GridIdentifier
    }
}

// MARK: - Grid
class GridIdentifier: NSObject {
    
    // MARK: - Constants
    
    // MARK: Variables
    var heroes: [Hero]
    
    init(heroes: [Hero]) {
        self.heroes = heroes
        super.init()
    }
    
    override func diffIdentifier() -> NSObjectProtocol {
        return self as NSObjectProtocol
    }
    
    override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? GridIdentifier else { return false }
        return self === object
    }
}
