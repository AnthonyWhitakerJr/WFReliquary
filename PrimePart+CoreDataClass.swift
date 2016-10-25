//
//  PrimePart+CoreDataClass.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/25/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData

public class PrimePart: NSManagedObject, Comparable {
    
    override public var description: String {
        return name
    }
    
    override public var hashValue: Int {
        return name.hashValue
    }
    
    init(name: String, isVaulted: Bool) {
        self.name = name
        self.isVaulted = isVaulted
    }
    
    // MARK: - Comparable
    public static func < (lhs: PrimePart, rhs: PrimePart) -> Bool {
        return lhs.name < rhs.name
    }
    
    public static func == (lhs: PrimePart, rhs: PrimePart) -> Bool {
        return lhs.name == rhs.name
    }
}
