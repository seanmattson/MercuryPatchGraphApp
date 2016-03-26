//
//  MetaWearBluetooth.swift
//  Mercury Patch Prototype
//
//  Created by Sean Mattson on 3/25/16.
//  Copyright © 2016 Sean Mattson. All rights reserved.
//

import Foundation

class MetaWearBluetoothObjC {
    let metaWearManager = MBLMetaWearManager.sharedManager()
    var devices: [MBLMetaWear]?
    var device: MBLMetaWear?
    var voltageData = [Double]()
    
    func getDevice() {
        print("Starting to Search")
        // I find it weird that connecting is in the closure for finding, but we'll see if it works
        metaWearManager.startScanForMetaWearsWithHandler({(array: [AnyObject]?) -> Void in
            print("Inside closure")
            self.devices = array as? [MBLMetaWear]
            for cur in self.devices! {
                cur.rememberDevice()
                print("Roll Tide")
                self.metaWearManager.stopScanForMetaWears()
                
                self.device = cur
                print(self.device)
                print(self.device?.state.rawValue)
                self.device?.connectWithHandler { (error: NSError?) -> Void in
                    self.device?.led?.flashLEDColorAsync(UIColor.redColor(), withIntensity:  0.5)
                    print("We are connected")
                }
            }
        })
    }
    
    func getValues() {
        // Confirm we making the graph start
        print("We getting this shit")
        self.device?.led?.flashLEDColorAsync(UIColor.greenColor(), withIntensity: 0.5)
        
        print(device?.gpio?.pins)
        // Digital Pin Shit
        guard device?.gpio?.pins != nil else {
            print("We done goofed")
            return
        }
        let pin4: MBLGPIOPin = device?.gpio?.pins[4] as! MBLGPIOPin
        pin4.configuration = MBLPinConfiguration.Pullup
        
        let pin6: MBLGPIOPin = device?.gpio?.pins[6] as! MBLGPIOPin
        pin6.configuration = MBLPinConfiguration.Pulldown
        
        let pin7: MBLGPIOPin = device?.gpio?.pins[7] as! MBLGPIOPin
        pin7.configuration = MBLPinConfiguration.Pulldown
        
        // Now reading from a pin
        
        let pin0: MBLGPIOPin = device?.gpio?.pins[0] as! MBLGPIOPin
        let periodicPinValue: MBLEvent = pin0.analogAbsolute.periodicReadWithPeriod(100)
        
        // Take Pin Reading and get some numbers
        
        periodicPinValue.startNotificationsWithHandlerAsync({(obj: AnyObject?, error: NSError?) in
            if let voltage = obj as? MBLNumericData {
                self.voltageData.append(Double(voltage.value))
                print(Double(voltage.value))
            }
        
        })
    }

}
