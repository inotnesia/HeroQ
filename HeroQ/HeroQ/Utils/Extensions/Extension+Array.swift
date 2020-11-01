//
//  Extension+Array.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 28/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import Foundation

extension Array {
    func unique<T: Hashable>(map: ((Element) -> (T))) -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
}
