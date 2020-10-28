//
//  HeroSectionController.swift
//  Project: HeroQ
//
//  Created by Tony Hadisiswanto on 27/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import IGListKit

// MARK: - HeroSectionController
class HeroSectionController: ListSectionController {
    
    // MARK: Variables
    private var identifier: HeroIdentifier?
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionContext = collectionContext else { return CGSize.zero }
        guard let identifier = identifier else { return CGSize.zero }
        return CGSize(width: collectionContext.containerSize.width, height: identifier.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: String(describing: HeroCollectionViewCell.self), bundle: nil, for: self, at: index) as? HeroCollectionViewCell
            else { return UICollectionViewCell() }
        cell.identifier = identifier
        return cell
    }
    
    override func didUpdate(to object: Any) {
        identifier = object as? HeroIdentifier
    }
}

// MARK: - Hero
class HeroIdentifier: NSObject {
    
    // MARK: Variables
    var height: CGFloat
    var hero: Hero
    
    init(height: CGFloat = 0, hero: Hero) {
        self.height = height
        self.hero = hero
        super.init()
    }
    
    override func diffIdentifier() -> NSObjectProtocol {
        return self as NSObjectProtocol
    }
    
    override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HeroIdentifier else { return false }
        return self === object
    }
}
