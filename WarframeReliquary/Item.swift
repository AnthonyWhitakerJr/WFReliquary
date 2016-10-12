//
//  Item.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Item : Comparable {
    
    let name: String!
    private(set) var isRetired: Bool!
    
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
