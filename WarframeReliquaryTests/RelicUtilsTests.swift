//
//  RelicUtilsTests.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/14/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import WarframeReliquary

class RelicUtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGroupByTier() {
        let relicsAll = CsvReader.parseRelicCsv()
        let relicsByTier = RelicUtils.groupByTier(relics: relicsAll)
        
        var totalCount = 0
        for (_, relics) in relicsByTier {
            totalCount += relics.count
        }
        
        XCTAssertEqual(relicsAll.count, totalCount)
        
        XCTAssertEqual(11, relicsByTier[.Lith]?.count)
        XCTAssertEqual(10, relicsByTier[.Meso]?.count)
        XCTAssertEqual(10, relicsByTier[.Neo]?.count)
        XCTAssertEqual(11, relicsByTier[.Axi]?.count)
        
        for tier in [Tier.Lith, Tier.Meso, Tier.Neo, Tier.Axi] {
            for relic in relicsByTier[tier]! {
                XCTAssertEqual(tier, relic.key.tier, "\(relic.description) is in the wrong group.")
            }
        }
        
        
    }
    
}
