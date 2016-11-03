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
    
    convenience init(name: String, isVaulted: Bool, imageName: String, ducatValue: Int16, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.isVaulted = isVaulted
        self.imageName = imageName
        self.ducatValue = ducatValue
    }
    
    // MARK: - Comparable
    public static func < (lhs: PrimePart, rhs: PrimePart) -> Bool {
        return lhs.name < rhs.name
    }
    
    public static func == (lhs: PrimePart, rhs: PrimePart) -> Bool {
        return lhs.name == rhs.name
    }
}
