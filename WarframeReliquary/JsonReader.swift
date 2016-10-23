//
//  JsonReader.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/18/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class JsonReader {
    
    let baseUrl = "http://content.warframe.com/MobileExport/"
    
    func parseJson(){
//        var error: NSError?
        let path = Bundle.main.path(forResource: "WeaponParts", ofType: "json")
        let data: Data? = path?.data(using: .utf8)
//        let url = URL(fileURLWithPath: path!)
        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        
        
//        let jsonData = NSData.dataWithContentsOfURL(path, options: .DataReadingMappedIfSafe, error: nil)
//        let jsonData2 = NSData.dat
//        
//        let jsonDict = JSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as NSDictionary
    }
    
}
