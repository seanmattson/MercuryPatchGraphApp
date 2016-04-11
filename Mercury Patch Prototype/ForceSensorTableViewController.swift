//
//  ForceSensorTableViewController.swift
//  Mercury Patch Prototype
//
//  Created by Sean Mattson on 3/27/16.
//  Copyright © 2016 Sean Mattson. All rights reserved.
//

import UIKit

class ForceSensorTableViewController: UITableViewController {
    let sensorLabels = ["Sensor 1", "Sensor 2", "Sensor 3", "Sensor 4", "Sensor 5", "Sensor 6", "Sensor 7"]
    //var sensorDelegate: ForceSensorTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = 80
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return pressureGenerator.sensorTypes.count
        return sensorLabels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get Labels for use in cells
        //let sensorLabels = pressureGenerator.sensorTypes.map { $0.rawValue }
        
        // Create instance of UITableViewCell, with default Appearance
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // Set text on the cell and where it is
        let sensor = sensorLabels[indexPath.row]
        cell.textLabel?.text = sensor
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If the triggered segue is the choose sensor segue
        if segue.identifier == "ChooseSensor" {
            
            // Figure out tapped row
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // Get sensor and pass it along
                print(row)
                let lineGraphViewController = segue.destinationViewController as! LineGraphViewController
                lineGraphViewController.sensorWeReading = row
            }
            
        }
    }
    
    
}
