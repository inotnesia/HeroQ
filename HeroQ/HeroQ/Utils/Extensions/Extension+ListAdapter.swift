//
//  Extension+ListAdapter.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 26/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import UIKit
import IGListKit

extension ListAdapter: ListAdapterDataSource {
    
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return []
    }
    
    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is ImageIdentifier:
            let view = viewController as? ImageProtocol
            return ImageSectionController(view: view)
//
//        case is MovieDetailIdentifier:
//            let view = viewController as? MovieDetailProtocol
//            return MovieDetailSectionController(view: view)
//
//        case is ReviewIdentifier:
//            let view = viewController as? ReviewProtocol
//            return ReviewSectionController(view: view)
//
//        case is TextIdentifier:
//            let view = viewController as? TextProtocol
//            return TextSectionController(view: view)

        default:
            return EmptySectionController()
        }
    }
}
