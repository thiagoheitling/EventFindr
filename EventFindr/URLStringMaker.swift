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
    var urlString = ""
    
    func makeURLString(latitude: String, longitude: String, category: String, date: String) -> String {
        
        if latitude != "" && longitude != "" {
            
            let radius = "50"
            urlString = eventfulSearchDomain + "page_size=50" + "&location=\(latitude),\(longitude)" + "&within=\(radius)" + "&category=\(category)" + "&date=\(date)" + "&app_key=\(eventfulKey)"
            
        } else {
            
            urlString = eventfulSearchDomain + "page_size=50" + "&category=\(category)" + "&date=\(date)" + "&app_key=\(eventfulKey)"
        }
        
        print("This is the searchURL: \(urlString)")
        
        return urlString
    }
}
