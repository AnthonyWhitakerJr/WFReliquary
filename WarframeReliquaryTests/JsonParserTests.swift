//
//  JsonParserTests.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/23/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest

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
        let path = Bundle.main.path(forResource: "WeaponParts", ofType: "json")
        let data: Data? = path?.data(using: .utf8)
        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        if let json = json as! [Dictionary<String, Any>]? {
            print("True")
            print("\(json)")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
