//
//  DetailViewController.swift
//  Parse_based_Instagram
//
//  Created by Tu Pham on 11/15/18.
//  Copyright © 2018 Van Lao. All rights reserved.
//

import UIKit
import Parse
class DetailViewController: UIViewController {
    
    var postDetail: Post!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        captionLabel.text = postDetail.caption
        let time = NSDate(timeIntervalSince1970: postDetail.timeInterval)
        timeLabel.text = time.description
        do{
            let image = try UIImage(data: postDetail.media.getData())
            postImage.image = image
        }
        catch {
            print("encountered an error")
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
