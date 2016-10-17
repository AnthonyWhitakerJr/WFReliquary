//
//  Item.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Item : Comparable, CustomStringConvertible, Hashable {

    let name: String!
    private(set) var isVaulted: Bool!
    
    var description: String {
        return name
    }
    
    var hashValue: Int {
        return name.hashValue
    }
    
    init(name: String, isVaulted: Bool) {
        self.name = name
        self.isVaulted = isVaulted
    }
    
    // MARK: - Comparable
    static func < (lhs: Item, rhs: Item) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
    }
}
