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

    let FEED_URL = "http://api.eventful.com/json/events/search?...&category=music&date=future&app_key=%22RvmHs99fRL7TWZ26%22"
    var eventsList = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView?.dataSource = self
//        tableView?.delegate = self
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: FEED_URL)
        let dataTask = session.dataTaskWithURL(url!) { (data, response, error) in
            
            if (data == nil) {
                print("no data, error: \(error)")
                return
            }
            
            // parse JSON
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                
                var eventTitle = String()
                var imageURLString = String()
                
                if let eventsDictionary = json["events"] as? [String: AnyObject] {
                
                    print(eventsDictionary)
                        
                    if let eventDict = eventsDictionary["event"] as? [[String: AnyObject]] {
                     
                        for event in eventDict {
                                
                            eventTitle = (event["title"] as? String)!
                            
                            if let imageDict = event["image"] as? [String: AnyObject] {
                                
                                if let small = imageDict["small"] as? [String: AnyObject] {
                                    
                                    imageURLString = (small["url"] as? String)!
//                                    imageURL = NSURL(string: imageURLString!)!
                                }
                            }
                            let event = Event()
                            event.title = eventTitle
                            event.imageURLString = imageURLString
                            self.eventsList.append(event)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

        let event = self.eventsList[indexPath.row]
        
        cell.configureWithResultsFeed(event)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
