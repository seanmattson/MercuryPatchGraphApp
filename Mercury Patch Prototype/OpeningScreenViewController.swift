//
//  OpeningScreenViewController.swift
//  Mercury Patch Prototype
//
//  Created by Sean Mattson on 4/14/16.
//  Copyright © 2016 Sean Mattson. All rights reserved.
//

import UIKit

class OpeningSceneViewController: UIViewController {
    
    let bluetooth = MetaWearBluetoothObjC.sharedInstance
    
    @IBOutlet weak var connectingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect to the bluetooth device
        bluetooth.getDevice {
            self.connectingLabel.text = "Connected!"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Check to see which button was clicked
        if segue.identifier == "CSegue" {
            let bluetoothChip = "C"
            let patchViewController = segue.destinationViewController as! PatchViewController
            patchViewController.bluetoothChip = bluetoothChip
        } else {
            let bluetoothChip = "R"
            let patchViewController = segue.destinationViewController as! PatchViewController
            patchViewController.bluetoothChip = bluetoothChip
        }
    }
    
}
