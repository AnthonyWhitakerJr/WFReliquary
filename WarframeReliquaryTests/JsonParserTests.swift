//
//  JsonParserTests.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/23/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import WarframeReliquary

class JsonParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let parts = JsonReader.parseJson()
        
        var writeMe = "warframe,image\n"
        
        for part in parts {
            writeMe.append("\(part.weaponName),\(part.imageName)")
            writeMe.append("\n")
        }
        
        print(writeMe)
        
        writeToFile(to: "warframePairings.csv", content: writeMe)
//        print("\(parts)")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func writeToFile(to filename: String, content: String) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(filename)
            print("\(path)")

            //writing
            do {
                try content.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
            
        }
    }
    
    
}
