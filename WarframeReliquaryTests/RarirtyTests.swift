//
//  RarirtyTests.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/14/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import WarframeReliquary

class RarirtyTests: XCTestCase {
    
    func testCases() {
        // Test values composition
        XCTAssertTrue(Rarity.values.contains(.Common))
        XCTAssertTrue(Rarity.values.contains(.Uncommon))
        XCTAssertTrue(Rarity.values.contains(.Rare))
        
        XCTAssertEqual(3, Rarity.values.count) // Test for additional values
        
        let rarity = Rarity.Common // Test for additional cases
        switch rarity {
        case .Common: break
        case .Uncommon: break
        case .Rare: break
        default: assertionFailure("This should never happen.")
        }
        
    }
    
}
