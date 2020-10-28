//
//  SimilarHeroesSectionController.swift
//  Project: HeroQ
//
//  Created by Tony Hadisiswanto on 28/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import IGListKit

// MARK: Protocols
protocol SimilarHeroesProtocol {
    func didHeroTapped(_ hero: Hero)
}

// MARK: - SimilarHeroesSectionController
class SimilarHeroesSectionController: ListSectionController {
    
    // MARK: Variables
    private var identifier: SimilarHeroesIdentifier?
    var view: SimilarHeroesProtocol?
    
    convenience init(view: SimilarHeroesProtocol?) {
        self.init()
        self.view = view
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionContext = collectionContext else { return CGSize.zero }
        guard let identifier = identifier else { return CGSize.zero }
        return CGSize(width: collectionContext.containerSize.width, height: identifier.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: String(describing: SimilarHeroesCollectionViewCell.self), bundle: nil, for: self, at: index) as? SimilarHeroesCollectionViewCell
            else { return UICollectionViewCell() }
        cell.items = identifier?.heroes
        cell.view = view
        return cell
    }
    
    override func didUpdate(to object: Any) {
        identifier = object as? SimilarHeroesIdentifier
    }
}

// MARK: - SimilarHeroes
class SimilarHeroesIdentifier: NSObject {
    
    // MARK: Variables
    var height: CGFloat
    var heroes: [Hero]
    
    init(height: CGFloat = 0, heroes: [Hero]) {
        self.height = height
        self.heroes = heroes
        super.init()
    }
    
    override func diffIdentifier() -> NSObjectProtocol {
        return self as NSObjectProtocol
    }
    
    override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? SimilarHeroesIdentifier else { return false }
        return self === object
    }
}
