//
//  DatesChosenString.swift
//  EventFindr
//
//  Created by Thiago Heitling on 2016-04-18.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class DatesChosen: NSObject {

    var rangeString = String()
    
    func makeDateRangeString (dateRange: DSLCalendarRange) -> String {

        var startMonthString = String()
        var startDayString = String()
        var endMonthString = String()
        var endDayString = String()

        startMonthString = twoDigitFormat(dateRange.startDay.month)
        startDayString = twoDigitFormat(dateRange.startDay.day)
        
        endMonthString = twoDigitFormat(dateRange.endDay.month)
        endDayString = twoDigitFormat(dateRange.endDay.day)
    
        rangeString = "\(dateRange.startDay.year)" + startMonthString + startDayString + "00" + "-" + "\(dateRange.endDay.year)" + endMonthString + endDayString + "00"

        return rangeString
    }
}

extension DatesChosen {
    
    func twoDigitFormat (number: NSInteger) -> String {
        
        if number < 10 {
            
            return "0" + "\(number)"
            
        } else {
            
            return "\(number)"
        }
    }
}
