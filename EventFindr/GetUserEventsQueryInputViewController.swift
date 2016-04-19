//
//  GetUserEventsQueryInputViewController.swift
//  EventFindr
//
//  Created by Thiago Heitling on 2016-04-15.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class GetUserEventsQueryInputViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CalendarVCDelegate {

    let categoryPickerData = [["music", "sports", "technology", "performing_arts", "movies_film", "all"]]
    
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var datesButton: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    let urlStringMaker = URLStringMaker()
    var categoryChosen = "music"
    var dateRangeString = String()
    var dateSelected = DSLCalendarRange()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Findr"
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Category Picker DataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return categoryPickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return categoryPickerData[component].count
    }
    
    // MARK: - Category Picker Delegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return categoryPickerData[component][row]
    }
    
    func pickerView(
        pickerView: UIPickerView,
        didSelectRow row: Int,
                     inComponent component: Int)
    {
        categoryChosen = categoryPickerData[0][categoryPicker.selectedRowInComponent(0)]
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showEvents" {

            var urlStringToShowFeed = String()
            
            if datesButton.titleLabel?.text == "all dates" {
                
                urlStringToShowFeed = urlStringMaker.makeURLString(categoryChosen, date: "Future")
            
            } else {
            
                urlStringToShowFeed = urlStringMaker.makeURLString(categoryChosen, date: dateRangeString)
            }
            
            let destVC = segue.destinationViewController as! SearchResultsTableViewController
            destVC.feed_URL_String = urlStringToShowFeed
            
            guard let formattedDate = datesButton.titleLabel?.text
                else { return }
            destVC.title = "\(categoryChosen)" + " " + "\(formattedDate)"
        
        }
    
        if segue.identifier == "ShowCalendar" {
            
            let destVC = segue.destinationViewController as! CalendarViewController
            destVC.delegate = self
        }
    }
    
    func userDidSelectDateRange(dateRange:String, buttonTitle: String) {
        
        self.datesButton.setTitle(buttonTitle, forState: .Normal)
        
        print("Button title = \(buttonTitle)")
        
        if buttonTitle != "all dates" {

            self.dateRangeString = dateRange
        
        } else {
            
            self.dateRangeString = ""
        
        }
    }
}
