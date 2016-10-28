//
//  SetComponent+CoreDataClass.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/27/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData

public class PrimeSetComponent: NSManagedObject, Comparable {
    
    convenience init(primeSet: PrimeSet, primePart: PrimePart, numberRequired: Int16, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        self.primeSet = primeSet
        self.primePart = primePart
        self.numberRequired = numberRequired
    }
    
    // MARK: - Comparable
    public static func < (lhs: PrimeSetComponent, rhs: PrimeSetComponent) -> Bool {
        
        if lhs.primeSet != rhs.primeSet {
            return lhs.primeSet < rhs.primeSet
        } else {
            return lhs.primePart < rhs.primePart
        }
    }
    
    public static func == (lhs: PrimeSetComponent, rhs: PrimeSetComponent) -> Bool {
        return lhs.primeSet == rhs.primeSet && lhs.primePart == rhs.primePart
    }

}
