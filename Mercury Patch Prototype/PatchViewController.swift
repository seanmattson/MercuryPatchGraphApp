//
//  PatchViewController.swift
//  Mercury Patch Prototype
//
//  Created by Sean Mattson on 4/6/16.
//  Copyright © 2016 Sean Mattson. All rights reserved.
//

import UIKit

class PatchViewController: UIViewController {
    
    let bluetooth = MetaWearBluetoothObjC.sharedInstance
    let sensorWeReading = 0
    var sensorButtons: [UIButton]?
    
    @IBOutlet weak var view1: UIButton!
    @IBOutlet weak var view2: UIButton!
    @IBOutlet weak var view3: UIButton!
    @IBOutlet weak var view4: UIButton!
    @IBOutlet weak var view5: UIButton!
    @IBOutlet weak var view6: UIButton!
    @IBOutlet weak var view7: UIButton!
    
    @IBOutlet weak var bluetoothConnection: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sensorButtons = [view1, view2, view3, view4, view5, view6, view7]
        
        bluetoothConnection.startAnimating()
        
        // Connect to the bluetooth device
        bluetooth.getDevice {
            self.bluetoothConnection.stopAnimating()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Check to see which segue was called
        if segue.identifier == "Sensor1" {
            // Choose the sensor to graph
            let sensorIndex = 1
            let lineGraphViewController = segue.destinationViewController as! LineGraphViewController
            lineGraphViewController.sensorWeReading = sensorIndex
        } else if segue.identifier == "Sensor2" {
            let sensorIndex = 2
            let lineGraphViewController = segue.destinationViewController as! LineGraphViewController
            lineGraphViewController.sensorWeReading = sensorIndex
        } else if segue.identifier == "Sensor3" {
            let sensorIndex = 3
            let lineGraphViewController = segue.destinationViewController as! LineGraphViewController
            lineGraphViewController.sensorWeReading = sensorIndex
        } else if segue.identifier == "Sensor4" {
            let sensorIndex = 4
            let lineGraphViewController = segue.destinationViewController as! LineGraphViewController
            lineGraphViewController.sensorWeReading = sensorIndex
        } else if segue.identifier == "Sensor5" {
            let sensorIndex = 5
            let lineGraphViewController = segue.destinationViewController as! LineGraphViewController
            lineGraphViewController.sensorWeReading = sensorIndex
        } else if segue.identifier == "Sensor6" {
            let sensorIndex = 6
            let lineGraphViewController = segue.destinationViewController as! LineGraphViewController
            lineGraphViewController.sensorWeReading = sensorIndex
        } else if segue.identifier == "Sensor7" {
            let sensorIndex = 0
            let lineGraphViewController = segue.destinationViewController as! LineGraphViewController
            lineGraphViewController.sensorWeReading = sensorIndex
        } else {
            let sensorIndex = 0
            let lineGraphViewController = segue.destinationViewController as! LineGraphViewController
            lineGraphViewController.sensorWeReading = sensorIndex
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        bluetooth.periodicPinValue?.stopNotificationsAsync()
    }
    
    
    
    @IBAction func startStreaming(sender: UIButton) {
        bluetooth.getValues{
            for sensor in 0..<self.bluetooth.sensorArray.count {
                if let voltageReading = self.bluetooth.sensorArray[sensor].sensorVoltageReadings.last {
                    print("Sensor \(sensor) has voltage \(voltageReading)")
                    switch sensor {
                    case 0:
                        if voltageReading >= 0.25 && voltageReading < 0.75 {
                            self.view7.backgroundColor = UIColor.yellowColor()
                        } else if voltageReading >= 0.75 {
                            self.view7.backgroundColor = UIColor.redColor()
                        } else {
                            self.view7.backgroundColor = UIColor.blueColor()
                        }
                    case 1:
                        if voltageReading >= 0.25 && voltageReading < 0.75 {
                            self.view1.backgroundColor = UIColor.yellowColor()
                        } else if voltageReading >= 0.75 {
                            self.view1.backgroundColor = UIColor.redColor()
                        } else {
                            self.view1.backgroundColor = UIColor.blueColor()
                        }
                    case 2:
                        if voltageReading >= 0.25 && voltageReading < 0.75 {
                            self.view2.backgroundColor = UIColor.yellowColor()
                        } else if voltageReading >= 0.75 {
                            self.view2.backgroundColor = UIColor.redColor()
                        } else {
                            self.view2.backgroundColor = UIColor.blueColor()
                        }
                    case 3:
                        if voltageReading >= 0.25 && voltageReading < 0.75 {
                            self.view3.backgroundColor = UIColor.yellowColor()
                        } else if voltageReading >= 0.75 {
                            self.view3.backgroundColor = UIColor.redColor()
                        } else {
                            self.view3.backgroundColor = UIColor.blueColor()
                        }
                    case 4:
                        if voltageReading >= 0.25 && voltageReading < 0.75 {
                            self.view4.backgroundColor = UIColor.yellowColor()
                        } else if voltageReading >= 0.75 {
                            self.view4.backgroundColor = UIColor.redColor()
                        } else {
                            self.view4.backgroundColor = UIColor.blueColor()
                        }
                    case 5:
                        if voltageReading >= 0.25 && voltageReading < 0.75 {
                            self.view5.backgroundColor = UIColor.yellowColor()
                        } else if voltageReading >= 0.75 {
                            self.view5.backgroundColor = UIColor.redColor()
                        } else {
                            self.view5.backgroundColor = UIColor.blueColor()
                        }
                    case 6:
                        if voltageReading >= 0.25 && voltageReading < 0.75 {
                            self.view6.backgroundColor = UIColor.yellowColor()
                        } else if voltageReading >= 0.75 {
                            self.view6.backgroundColor = UIColor.redColor()
                        } else {
                            self.view6.backgroundColor = UIColor.blueColor()
                        }
                    default:
                        print("Index is out of range")
                    }
                }
            }
        }
    }
    
    @IBAction func stopStreaming(sender: UIButton) {
        view1.backgroundColor = UIColor.orangeColor()
        view2.backgroundColor = UIColor.orangeColor()
        view3.backgroundColor = UIColor.orangeColor()
        view4.backgroundColor = UIColor.orangeColor()
        view5.backgroundColor = UIColor.orangeColor()
        view6.backgroundColor = UIColor.orangeColor()
        view7.backgroundColor = UIColor.orangeColor()
        bluetooth.periodicPinValue?.stopNotificationsAsync()
    }
    
    
}
