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

    
    

    
    @IBOutlet weak var captionLabel: UILabel!
    
   
    @IBOutlet weak var feedImage: PFImageView!
    
    var post: Post!{
        didSet{
            self.feedImage.file = post["media"] as? PFFile
            self.feedImage.loadInBackground()
            self.captionLabel.text = post.caption
            //cell.captionLabel.text = feed.caption
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        feedImage.layer.cornerRadius = 2 //make feed image corner rounder.
        feedImage.clipsToBounds = true

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
