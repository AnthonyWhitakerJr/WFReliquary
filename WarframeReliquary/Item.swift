//
//  Item.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Item {
    
    private(set) var name: String!
    private(set) var isRetired: Bool!
    
    init(name: String, isRetired: Bool) {
        self.name = name
        self.isRetired = isRetired
    }
}
