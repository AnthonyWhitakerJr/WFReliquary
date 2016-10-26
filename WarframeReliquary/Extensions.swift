//
//  Extensions.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/26/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
