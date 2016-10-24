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
    
    static func parseJson(){
////        var error: NSError?
//        let path = Bundle.main.path(forResource: "WeaponParts", ofType: "json")
//        let data: Data? = path?.data(using: .utf8)
////        let url = URL(fileURLWithPath: path!)
//        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
//        
//        if let path = Bundle.main.path(forResource: "WeaponsParts", ofType: "json")
//        {
//            if let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
//            {
//                if let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
//                {
//                    if let persons : NSArray = jsonResult["person"] as? NSArray
//                    {
//                        // Do stuff
//                    }
//                }
//            }
//        }
        
        if let path = Bundle.main.path(forResource: "WeaponsParts", ofType: "json") {
            do {
                print("path: \(path)")
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    print("jsonData: \(jsonData)")
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print("jsonResult: \(jsonResult)")
                    if let manifest : [NSDictionary] = jsonResult["manifest"] as? [NSDictionary] {
                        for part: NSDictionary in manifest {
                            for (name,value) in part {
                                print("\(name) , \(value)")
                            }
                        }
                    }
                } catch {}
            } catch {}
        }
        
        
//        let jsonData = NSData.dataWithContentsOfURL(path, options: .DataReadingMappedIfSafe, error: nil)
//        let jsonData2 = NSData.dat
//        
//        let jsonDict = JSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as NSDictionary
    }
    
}
