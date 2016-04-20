//
//  GetUserEventsQueryInputViewController.swift
//  EventFindr
//
//  Created by Thiago Heitling on 2016-04-15.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit
import GoogleMaps

class GetUserEventsQueryInputViewController: UIViewController, LocateOnTheMap, UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource, CalendarVCDelegate {

    let categoryPickerData = [["music", "sports", "technology", "performing_arts", "movies_film", "all"]]
    
    @IBOutlet weak var datesButton: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    let urlStringMaker = URLStringMaker()
    var categoryChosen = "music"
    var dateRangeString = String()
    var dateSelected = DSLCalendarRange()
    
    @IBOutlet weak var googleMapsContainer: UIView!
    var googleMapsView: GMSMapView!
    var searchLatitude = ""
    var searchLongitude = ""
    var resultsArray = [String]()
    var searchResultPlacesController: SearchPlacesResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datesButton.layer.borderWidth = 0.7
        datesButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.googleMapsView = GMSMapView(frame: self.googleMapsContainer.frame)
        self.view.addSubview(self.googleMapsView)
        self.googleMapsView.layer.opacity = 0.50
        searchResultPlacesController = SearchPlacesResultsController()
        searchResultPlacesController.delegate = self
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        self.navigationController?.view.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let attributes = [NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 12)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.title = "all cities"
    }
    
    // MARK: - Actions
    
    @IBAction func searchPlacesButtonPressed(sender: UIBarButtonItem) {
        
        let searchController = UISearchController(searchResultsController: searchResultPlacesController)
        searchController.searchBar.delegate = self
        self.presentViewController(searchController, animated: true, completion: nil)
        
    }
    
    func locateWithLongitude(lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.cameraWithLatitude(lat, longitude: lon, zoom: 10)
            self.googleMapsView.camera = camera
            
            marker.title = "Address: \(title)"
            marker.map = self.googleMapsView
            
            self.searchLatitude = "\(position.latitude)"
            self.searchLongitude = "\(position.longitude)"
            self.title = "\(title)"
            
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let placeClient = GMSPlacesClient()
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil) { (results, error: NSError?) -> Void in
            
            self.resultsArray.removeAll()
            if results == nil {
                return
            }
            
            for result in results! {
                let result = result as GMSAutocompletePrediction
                self.resultsArray.append(result.attributedFullText.string)
            }
            
            self.searchResultPlacesController.reloadDataWithArray(self.resultsArray)
            
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(true, animated: true)
        for ob: UIView in ((searchBar.subviews[0] )).subviews {
            
            if let z = ob as? UIButton {
                let btn: UIButton = z
                btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            }
        }
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
    
    // MARK: - Category PickerView Delegates
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.whiteColor()
        
        for categoryData in categoryPickerData {
            
            pickerLabel.text = categoryData[row]
        }
        pickerLabel.font = UIFont(name: "Helvetica Neue", size: 18)
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showEvents" {

            var urlStringToShowFeed = String()
            
            if datesButton.titleLabel?.text == "all dates" {
                
                urlStringToShowFeed = urlStringMaker.makeURLString(self.searchLatitude, longitude: self.searchLongitude, category: categoryChosen, date: "Future")
            
            } else {
            
                                urlStringToShowFeed = urlStringMaker.makeURLString(self.searchLatitude, longitude: self.searchLongitude, category: categoryChosen, date: dateRangeString)
            }
            
            let destVC = segue.destinationViewController as! SearchResultsTableViewController
            destVC.feed_URL_String = urlStringToShowFeed
            
            guard let formattedDate = datesButton.titleLabel?.text
                else { return }
            destVC.title = "\(categoryChosen) on \(formattedDate)"
        
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
