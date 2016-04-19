//
//  ResultsFeed.swift
//  EventFindr
//
//  Created by Thiago Heitling on 2016-04-14.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import Foundation
import UIKit

class Event {
    
    var title: String
    var imageURLString: String
    var category: String
    var venue: String
    var date: String
    
    init () {
        self.title = ""
        self.category = "music"
        self.imageURLString = ""
        self.venue = ""
        self.date = ""
    }
    
}