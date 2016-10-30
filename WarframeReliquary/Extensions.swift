//
//  Extensions.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/26/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

extension String {
    var isBlank: Bool {
        return isEmpty || trimmed.isEmpty
    }
    
    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

extension UILongPressGestureRecognizer {
    
    open func isOutsideView() -> Bool {
        let frame = CGRect(x: 0, y: 0, width: self.view!.frame.width, height: self.view!.frame.height)
        return !frame.contains(self.location(in: self.view!))
    }
}
