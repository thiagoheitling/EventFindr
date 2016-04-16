//
//  URLMaker.swift
//  EventFindr
//
//  Created by Thiago Heitling on 2016-04-15.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class URLStringMaker: NSObject {

    var eventfulKey = APIKey().eventfulAPIAppID
    let eventfulSearchDomain = "http://api.eventful.com/json/events/search?"
    
    func makeURLString(category: String, date: String) -> String {
        
        let urlString = eventfulSearchDomain + "category=" + category + "&date=" + date + "&app_key=" + eventfulKey
        
        print("This is the searchURL: \(urlString)")
        
        return urlString
    }
}
