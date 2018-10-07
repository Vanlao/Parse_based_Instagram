//
//  HomeFeedViewCell.swift
//  Parse_based_Instagram
//
//  Created by Tu Pham on 10/5/18.
//  Copyright © 2018 Van Lao. All rights reserved.
//

import UIKit
import Parse
import ParseUI
class HomeFeedViewCell: UITableViewCell {

    @IBOutlet weak var FeedImage: UIImageView!
    
    @IBOutlet weak var feedImage1: PFImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    var feed: Post!{
        didSet{
            print("post set!")
            self.feedImage1.file = feed["media"] as! PFFile
            self.feedImage1.loadInBackground()
            self.captionLabel.text = feed["caption"] as! String
            print(self.captionLabel.text)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        feedImage1.layer.cornerRadius = 2 //make feed image corner rounder.
        feedImage1.clipsToBounds = true

        captionLabel.preferredMaxLayoutWidth = captionLabel.frame.size.width //autolayout.
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews() //when the layout is changed
        
        captionLabel.preferredMaxLayoutWidth = captionLabel.frame.size.width //autolayout.
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
