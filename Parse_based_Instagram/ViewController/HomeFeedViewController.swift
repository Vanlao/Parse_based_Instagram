//
//  HomeFeedViewController.swift
//  Parse_based_Instagram
//
//  Created by Tu Pham on 10/5/18.
//  Copyright © 2018 Van Lao. All rights reserved.
//

import UIKit
import Parse

class HomeFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewer: UITableView!
    

    var feeds: [Post] = []
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeFeedViewController.PulledToRefresh(_:)), for: .valueChanged)
        tableViewer.insertSubview(refreshControl, at: 0)
        tableViewer.delegate = self
        tableViewer.dataSource = self
        tableViewer.rowHeight = UITableView.automaticDimension //autolayout.
        tableViewer.estimatedRowHeight = 400
        fetch()
        // Do any additional setup after loading the view.
    }
    @objc func PulledToRefresh(_ refreshControl: UIRefreshControl){
        fetch()
    }
    @IBAction func onLogOut(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "", message: "Are you sure you want to log out ?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            // handle response here.
            NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
            print("OK button tapped")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        alertController.addAction(cancelAction)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
        
    }
    
    @IBAction func OnCompose(_ sender: AnyObject) {
        //create image pick controller.
        
        self.performSegue(withIdentifier: "ComposeSegue", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if feeds != nil{
            return feeds.count
        }
        else{
            return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! HomeFeedViewCell
        let feed = feeds[indexPath.row]
        cell.post = feed
        
        return cell
    }
    func fetch(){
        let querry = Post.query()
        querry?.order(byDescending: "createdAt")
        querry?.limit = 20
        querry?.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                print("objects found")
                
                if let objects = objects as? [Post]{
                    self.feeds = objects as! [Post]
                    self.tableViewer.reloadData()
                    self.refreshControl.endRefreshing()
                    print("refreshed")
                }
                
                
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "postDetailSegue"){
            let cell = sender as! HomeFeedViewCell
            let indexPath = tableViewer.indexPath(for: cell)!
            let feed = feeds[indexPath.row]
            let detailViewControl = segue.destination as! DetailViewController
            detailViewControl.postDetail = feed
        }
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
