//
//  ImageSectionController.swift
//  Project: HeroQ
//
//  Created by Tony Hadisiswanto on 27/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import IGListKit

// MARK: Protocols
protocol ImageProtocol {
    func didHeroTapped(_ hero: Hero)
}

// MARK: - ImageSectionController
class ImageSectionController: ListSectionController {
    
    // MARK: - Constants
    
    // MARK: Variables
    private var identifier: ImageIdentifier?
    var view: ImageProtocol?
    
    convenience init(view: ImageProtocol?) {
        self.init()
        self.view = view
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionContext = collectionContext else { return CGSize.zero }
        guard let identifier = identifier else { return CGSize.zero }
        return CGSize(width: collectionContext.containerSize.width - 16, height: identifier.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: String(describing: ImageCollectionViewCell.self), bundle: nil, for: self, at: index) as? ImageCollectionViewCell
            else { return UICollectionViewCell() }
        
        if let imageURL = identifier?.hero.imageURL, let title = identifier?.hero.localizedName {
            cell.setupView(imageURL: imageURL, title: title)
            cell.view = view
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        identifier = object as? ImageIdentifier
    }
    
    override func didSelectItem(at index: Int) {
        guard let identifier = identifier else { return }
        view?.didHeroTapped(identifier.hero)
    }
}

// MARK: - Image
class ImageIdentifier: NSObject {
    
    // MARK: - Constants
    
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
        guard let object = object as? ImageIdentifier else { return false }
        return self === object
    }
}
