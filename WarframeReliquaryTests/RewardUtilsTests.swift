//
//  RewardUtilsTests.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/18/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import WarframeReliquary

class RewardUtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetDropOdds() {
        let items = CsvReader.parseItemCsv()
        let relics = CsvReader.parseRelicCsv()
        let rewardsAll = CsvReader.parseRewardCsv(relics: relics, items: items)
        
        let rewardsByRelic = RewardUtils.groupByRelic(rewards: rewardsAll)
        
        var relicsFour = [Relic]()
        for (_, relic) in relics {
            relicsFour.append(relic)
            if relicsFour.count == 4 { break }
        }
        
        var rewards = RewardUtils.rewards(for: relicsFour, from: rewardsByRelic)
        RewardUtils.setDropOdds(for: &rewards)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
