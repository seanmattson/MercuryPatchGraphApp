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
        
        bluetoothConnection.startAnimating()
        
        // Connect to the bluetooth device
        bluetooth.getDevice {
            self.bluetoothConnection.stopAnimating()
        }
    }
    
    
    
    @IBAction func startStreaming(sender: UIButton) {
        bluetooth.getValues{
            
        }
    }
    
    @IBAction func stopStreaming(sender: UIButton) {
        view2.backgroundColor = UIColor.yellowColor()
    }
    
    
}
