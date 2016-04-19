//
//  NSdateFormatter+Extension.swift
//  EventFindr
//
//  Created by Thiago Heitling on 2016-04-18.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import Foundation

extension NSDateFormatter {
    
    func localizedFormat(desiredFormat:String) -> String {
        
        if let locale = locale, localizedFormatString = NSDateFormatter.dateFormatFromTemplate(desiredFormat, options: 0, locale: locale) {
            
            return localizedFormatString
        }
        return desiredFormat
    }
}