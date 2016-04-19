//
//  SearchResultsTableViewController.swift
//  EventFindr
//
//  Created by Thiago Heitling on 2016-04-14.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ResultCell"

class SearchResultsTableViewController: UITableViewController {
    
    var feed_URL_String = String()
    var eventsList = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 12)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: feed_URL_String)
        let dataTask = session.dataTaskWithURL(url!) { (data, response, error) in
            
            if (data == nil) {
                print("no data, error: \(error)")
                return
            }
            
            // parse JSON
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:NSObject],
                    let eventsDictionary = json["events"] as? [String: AnyObject],
                    let eventArray = eventsDictionary["event"] as? [[String: AnyObject]] {
                    
                    //print(eventsDictionary)
                    
                    for event in eventArray {
                    
                        if let imageDict = event["image"] as? [String: AnyObject] {
                            
                            if let medium = imageDict["medium"] as? [String: AnyObject] {
                                
                                let imageURLString = (medium["url"] as? String)
                                
                                if imageURLString != nil && imageURLString != "" {
                                    
                                    guard let eventTitle = (event["title"] as? String),
                                        let eventVenue = (event["venue_name"] as? String),
                                        let eventDate = (event["start_time"] as? String)
                                        else {return}
                                    
                                    let dateFormatter = NSDateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                    let eventNSDate = dateFormatter.dateFromString(eventDate)
                                    
                                    let formatter = NSDateFormatter()
                                    formatter.dateFormat = formatter.localizedFormat("MMMM dd, yyyy")
                                    formatter.timeZone = NSTimeZone(name: "UTC")
                                    
                                    let eventDateFormatted = formatter.stringFromDate(eventNSDate!)
                                    
                                    print(eventTitle)
                                    
                                    let event = Event()
                                    event.title = eventTitle
                                    event.venue = eventVenue
                                    event.date = eventDateFormatted
                                    event.imageURLString = imageURLString!
                                    self.eventsList.append(event)
                                }
                            }
                        }
                    }
                }
                
            } catch {
                
                print("json error: \(error)")
            }
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                
                self.tableView.reloadData()
            }
        }
        
        dataTask.resume()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SearchResultsTableViewCell
        
        cell.eventImageView.image = nil
        let event = self.eventsList[indexPath.row]
        cell.configureWithResultsFeed(event)
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
