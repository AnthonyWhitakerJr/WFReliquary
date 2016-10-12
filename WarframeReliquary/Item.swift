//
//  Item.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Item : Comparable, CustomStringConvertible {

    let name: String!
    private(set) var isRetired: Bool!
    
    var description: String {
        return name
    }
    
    init(name: String, isRetired: Bool) {
        self.name = name
        self.isRetired = isRetired
    }
    
    // MARK: - Comparable
    static func < (lhs: Item, rhs: Item) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
    }
}
