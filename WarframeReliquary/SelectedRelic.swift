//
//  SelectedRelic.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class SelectedRelic: Comparable {
    
    var relic: Relic
    var quality: Quality = .Intact
    
    init(relic: Relic) {
        self.relic = relic
    }
    
    func cycleQuality() {
        quality = Quality.values[(Quality.values.index(of: quality)! + 1) % Quality.values.count]
    }
    
    // MARK: - Comparable
    public static func < (lhs: SelectedRelic, rhs: SelectedRelic) -> Bool {
        return lhs.relic < rhs.relic
    }
    
    public static func == (lhs: SelectedRelic, rhs: SelectedRelic) -> Bool {
        return lhs.relic == rhs.relic
    }
}
