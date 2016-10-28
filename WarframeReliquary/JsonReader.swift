//
//  JsonReader.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/18/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class JsonReader {
    
    static let baseUrl = "http://content.warframe.com/MobileExport"
    
    public struct WeaponPart {
        public var name: String
        public var imageLocation: String
        
        public var weaponName: String {
            return name.replacingOccurrences(of: "/Lotus/Types/Recipes/WarframeRecipes/", with: "")
        }
        
        public var imagePath: String {
            let path = imageLocation.replacingOccurrences(of: "\\", with: "/")
            return "\(baseUrl)\(path)"
        }
        
        public var imageName: String {
            return imageLocation.replacingOccurrences(of: "\\Lotus\\Interface\\Icons\\Store\\", with: "")
        }
    }
    
    static func parseJson() -> [WeaponPart]{
        var weaponParts = [WeaponPart]()
        if let path = Bundle.main.path(forResource: "WarframeParts", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    if let manifest = jsonResult["Manifest"] as? [NSDictionary] {
                        for part: NSDictionary in manifest {
                            let name = part["uniqueName"] as! String
                            let imageLocation = part["textureLocation"] as! String
                            
                            let weaponPart = WeaponPart(name: name, imageLocation: imageLocation)
                            weaponParts.append(weaponPart)
                        }
                    }
                } catch {}
            } catch {}
        }
        
        return weaponParts
    }
    
}
