//
//  EmptySectionController.swift
//  Project: HeroQ
//
//  Created by Tony Hadisiswanto on 26/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import IGListKit

// MARK: - EmptySectionController
class EmptySectionController: ListSectionController {
    
    // MARK: - Constants
    
    // MARK: Variables
    private var identifier: EmptyIdentifier?
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionContext = collectionContext else { return CGSize.zero }
        guard let identifier = identifier else { return CGSize.zero }
        return CGSize(width: collectionContext.containerSize.width, height: identifier.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: String(describing: EmptyCollectionViewCell.self), bundle: nil, for: self, at: index) as? EmptyCollectionViewCell
            else { return UICollectionViewCell() }
        cell.backgroundColor = identifier?.backgroundColor
        return cell
    }
    
    override func didUpdate(to object: Any) {
        identifier = object as? EmptyIdentifier
    }
    
}

// MARK: - Empty
class EmptyIdentifier: NSObject {
    
    // MARK: Variables
    var height: CGFloat
    var backgroundColor: UIColor
    
    init(height: CGFloat = 0, backgroundColor: UIColor = .clear) {
        self.height = height
        self.backgroundColor = backgroundColor
        super.init()
    }
    
    override func diffIdentifier() -> NSObjectProtocol {
        return self as NSObjectProtocol
    }
    
    override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? EmptyIdentifier else { return false }
        return self === object
    }
}
