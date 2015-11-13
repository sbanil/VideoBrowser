//
//  MasterViewController.swift
//  VideoBrowser
//
//  Created by Sanghubattla, Anil on 10/18/15.
//  Copyright © 2015 teamcakes. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var videos : Array<VideoModel> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDataFromJsonFile()
        //self.loadDataOverNetwork()
    }

    
    @IBAction func refreshData(sender: AnyObject) {
        
        self.loadDataFromJsonFile()
    }

    
    func loadDataFromJsonFile()
    {
        
        if let path = NSBundle.mainBundle().pathForResource("VideoData", ofType: "json")
        {
            do
            {
                if let jsonData = try? NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                {
                    
                    let jarr =  try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    

                    for obj in jarr {
                        if let v = obj as? NSDictionary {
                            let vbo = VideoModel(json: v)
                            videos.append(vbo!)
                        }
                    }
                }
            } catch {
                //TODO: Add error handling here
                
            }
        }
    }
    
    func loadDataOverNetwork()
    {
        
        let onSuccess: (NSArray) -> Void = {
            (videolist) in
            
            for obj in videolist {
                if let v = obj as? NSDictionary {
                    let vbo = VideoModel(json: v)
                    self.videos.append(vbo!)
                }
            }
            
            self.tableView.reloadData()
        };
        
        let onFailure: (errorDesc: String) -> Void =  {
            (errString) in
            print(errString)
        };
        
        ServiceHelper().retrieveVideoList(onSuccess, OnFailure: onFailure);
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

 
    // MARK: - Table View
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let object = videos[indexPath.item]
        let customCell = cell as! VideoListcell
        customCell.videoLength.text = (String(object.videoLength) + (object.videoLength > 1 ? " Second" : " Seconds"))
        customCell.videoName.text = object.videoName
        customCell.videoPreview.image = object.posterImage
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            
            if segue.identifier == "showDetail" {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    let object = videos[indexPath.item]
                    
                    let controller = (segue.destinationViewController
                        as! UINavigationController).topViewController
                        as! DetailViewController
                    
                    controller.detailItem = object
                    controller.navigationItem.leftBarButtonItem =
                        splitViewController?.displayModeButtonItem()
                    controller.navigationItem.leftItemsSupplementBackButton = true
                }
            }
    }
}

