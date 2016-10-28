//
//  Set+CoreDataClass.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/27/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData

public class PrimeSet: NSManagedObject, Comparable {

    convenience init(name: String, imageName: String, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.imageName = imageName
    }
    
    // MARK: - Comparable
    public static func < (lhs: PrimeSet, rhs: PrimeSet) -> Bool {
        return lhs.name < rhs.name
    }
    
    public static func == (lhs: PrimeSet, rhs: PrimeSet) -> Bool {
        return lhs.name == rhs.name
    }
}
