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
    
    struct WeaponPart {
        var name: String
        var imagePath: String
    }
    
    static func parseJson() -> [WeaponPart]{
        var weaponParts = [WeaponPart]()
        if let path = Bundle.main.path(forResource: "WeaponParts", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    if let manifest = jsonResult["Manifest"] as? [NSDictionary] {
                        for part: NSDictionary in manifest {
                            let name = part["uniqueName"] as! String
                            let imagePath = part["textureLocation"] as! String
                            
                            let weaponPart = WeaponPart(name: name, imagePath: imagePath)
                            weaponParts.append(weaponPart)
                        }
                    }
                } catch {}
            } catch {}
        }
        
        return weaponParts
    }
    
}
