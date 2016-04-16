//
//  GetUserEventsQueryInputViewController.swift
//  EventFindr
//
//  Created by Thiago Heitling on 2016-04-15.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class GetUserEventsQueryInputViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let categoryPickerData = [["all", "music", "sports", "technology", "performing_arts", "movies_film"]]
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    let urlStringMaker = URLStringMaker()
    var categoryChosen = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

            let urlStringMakerResponse = urlStringMaker.makeURLString(categoryChosen, date: dateTextField.text!)
            let destVc = segue.destinationViewController as! SearchResultsTableViewController            
            destVc.feed_URL_String = urlStringMakerResponse
        }
        
    }

}
