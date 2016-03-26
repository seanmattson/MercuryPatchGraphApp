//
//  MetaWearBluetooth.swift
//  Mercury Patch Prototype
//
//  Created by Sean Mattson on 3/25/16.
//  Copyright © 2016 Sean Mattson. All rights reserved.
//

import Foundation

class MetaWearBluetooth {
    let metaWearManager = MBLMetaWearManager.sharedManager()
    var devices: [MBLMetaWear]?
    var device: MBLMetaWear?
    
    func getDevice() {
        metaWearManager.startScanForMetaWearsWithHandler({(array: [AnyObject]?) -> Void in
            self.devices = array as? [MBLMetaWear]
            for cur in self.devices! {
                if cur.discoveryTimeRSSI?.integerValue > -15 {
                    continue
                }
                
                if cur.discoveryTimeRSSI?.integerValue < -60 {
                    continue
                }
                cur.rememberDevice()
                
                self.metaWearManager.stopScanForMetaWears()
                
                self.device = cur
                
                self.device?.connectWithHandler { (error: NSError?) -> Void in
                    if !(error == nil) {
                        self.device?.led?.flashLEDColorAsync(UIColor.redColor(), withIntensity:  0.5)
                    }
                }
            }
        })
    }

}
