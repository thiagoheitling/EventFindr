//
//  EventFindrTest01.swift
//  EventFindr
//
//  Created by Thiago Heitling on 2016-04-20.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import XCTest
@testable import EventFindr

class EventFindrTest01: XCTestCase {
    
    var event = Event()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        event.title = "Title"
        event.category = "Arts"
        event.imageURLString = "http://utesting.com"
        event.venue = "Balroom1"
        event.date = "May 25, 2016"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEventTitleProperty() {
        
        let result = event.title
        let expected = "Title"
        
        XCTAssertEqual(expected, result, "Event title should be = Title")
    }

    func testEventCategoryProperty() {
        
        let result = event.category
        let expected = "Arts"
        
        XCTAssertEqual(expected, result, "Event category should be = Arts")
    }
    
    func testEventImageURLStringProperty() {
        
        let result = event.imageURLString
        let expected = "http://utesting.com"
        
        XCTAssertEqual(expected, result, "Event ImageURLString should be = http://utesting.com")
    }
    
    func testEventVenueProperty() {
        
        let result = event.venue
        let expected = "Balroom1"
        
        XCTAssertEqual(expected, result, "Event venue should be = Balroom1")
    }
    
    func testEventDateProperty() {
        
        let result = event.date
        let expected = "May 25, 2016"
        
        XCTAssertEqual(expected, result, "Event venue should be = May 25, 2016")
    }
}
