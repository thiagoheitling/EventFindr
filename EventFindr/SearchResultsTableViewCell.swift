//
//  SearchResultsTableViewCell.swift
//  EventFindr
//
//  Created by Thiago Heitling on 2016-04-14.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    func configureWithResultsFeed(event: Event) {
        
        eventTitleLabel.text = event.title
        downloadedFrom(link: event.imageURLString, contentMode: .ScaleAspectFit)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SearchResultsTableViewCell {
    
    func downloadedFrom(link link:String, contentMode mode: UIViewContentMode) {
        guard
            let url = NSURL(string: link)
            else {return}
        contentMode = mode
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                
                self.eventImageView.image = image
            }
        }).resume()
    }
}