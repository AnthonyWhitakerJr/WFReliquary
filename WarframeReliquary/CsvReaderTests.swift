//
//  CsvReaderTests.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/12/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import WarframeReliquary

class CsvReaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseItemCsv() {
        let items = CsvReader.parseItemCsv()
        XCTAssertEqual(122, items.count, "Incorrect number of Items read from file.")
    }
    
    func testparseRelicCsv() {
        let relics = CsvReader.parseRelicCsv()
        XCTAssertEqual(42, relics.count, "Incorrect number of Relics read from file.")
    }
    
    func testparseRewardCsv() {
        let items = CsvReader.parseItemCsv()
        let relics = CsvReader.parseRelicCsv()
        let rewards = CsvReader.parseRewardCsv(relics: relics, items: items)
        
        let expectedRewardCount = relics.count * 6
        XCTAssertEqual(expectedRewardCount, rewards.count, "Incorrect number of Rewards read from file.")
        
        let rewardsTable = RewardUtils.groupByRelic(rewards: rewards)
        for (relicKey, relicRewards) in rewardsTable {
            XCTAssertEqual(6, relicRewards.count, "Improper reward count for \(relicKey).")
            
            var common = 0, uncommon = 0, rare = 0
            for reward in relicRewards {
                switch reward.rarity {
                case .Common:
                    common += 1
                case .Uncommon:
                    uncommon += 1
                case .Rare:
                    rare += 1
                }
            }
            
            XCTAssertEqual(3, common, "Improper common count for \(relicKey).")
            XCTAssertEqual(2, uncommon, "Improper uncommon count for \(relicKey).")
            XCTAssertEqual(1, rare, "Improper rare count for \(relicKey).")
        }
    }
    
}
