//
//  EventFindrTest02.swift
//  EventFindr
//
//  Created by Thiago Heitling on 2016-04-20.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import XCTest
@testable import EventFindr

class EventFindrTest02: XCTestCase {
    
    var evenfulAPIKey = APIKey()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEventFulAPIKeyValue() {

        let result = evenfulAPIKey.eventfulAPIAppID
        let expected = "RvmHs99fRL7TWZ26"
        
        XCTAssertEqual(expected, result, "EventFulAPIKey should be = RvmHs99fRL7TWZ26")
    }
    
}
