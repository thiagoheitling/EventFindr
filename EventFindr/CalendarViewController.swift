//
//  CalendarViewController.swift
//  EventFindr
//
//  Created by Thiago Heitling on 2016-04-18.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

protocol CalendarVCDelegate: class {
    func userDidSelectDateRange(dateRange:String, buttonTitle:String)
}

class CalendarViewController: UIViewController, UINavigationControllerDelegate, DSLCalendarViewDelegate {

    @IBOutlet weak var calendarView: DSLCalendarView!
    @IBOutlet weak var allDatesButton: UIButton!
    @IBOutlet weak var setRangeButton: UIButton!
    
    weak var delegate: CalendarVCDelegate?
    
    var range = DSLCalendarRange()
    let datesChosen = DatesChosen()
    var dateRangeString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allDatesButton.layer.borderWidth = 0.7
        allDatesButton.layer.borderColor = UIColor.whiteColor().CGColor
        setRangeButton.layer.borderWidth = 0.7
        setRangeButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        navigationController?.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "choose dates"
        
        calendarView.delegate = self
    }

    func calendarView(calendarView: DSLCalendarView!, didSelectRange range: DSLCalendarRange!) {
        
        if range != nil {
        
            self.range = range
            dateRangeString = datesChosen.makeDateRangeString(range)
            print(datesChosen.rangeString)
        }
    }
    
    // MARK: - ACtions
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
    
        navigationController?.popViewControllerAnimated(true)
    
    }
    
    @IBAction func allDatesButtonPressed(sender: UIButton) {
        
        delegate?.userDidSelectDateRange("Future", buttonTitle: "all dates")
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func setRangeButtonPressed(sender: AnyObject) {
        
        if self.range.startDay != nil {
        
            let formatter = NSDateFormatter()
            formatter.dateFormat = formatter.localizedFormat("MMMM dd, yyyy")
            formatter.timeZone = NSTimeZone(name: "UTC")
            
            let rangeFormattedString = formatter.stringFromDate(self.range.startDay.date!) + " to " + formatter.stringFromDate(self.range.endDay.date!)
            
            delegate?.userDidSelectDateRange(dateRangeString, buttonTitle: rangeFormattedString)
            
            navigationController?.popViewControllerAnimated(true)
            
        } else {
            
            let alert = UIAlertController(title: "Hi there!", message:"Please, choose dates before pressing me!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        }
    }
    
/*
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    } */
    
}
