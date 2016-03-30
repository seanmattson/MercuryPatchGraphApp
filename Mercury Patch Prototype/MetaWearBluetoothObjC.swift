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
    var periodicPinValue: MBLEvent?
    var voltageData = [Double]()
    
    // Create the voltage Arrays
    var voltageData1 = [Double]()
    var voltageData2 = [Double]()
    var voltageData3 = [Double]()
    var voltageData4 = [Double]()
    var voltageData5 = [Double]()
    var voltageData6 = [Double]()
    var voltageData7 = [Double]()
    
    //Initializing pins for pin state
    var pin4: MBLGPIOPin?
    var pin6: MBLGPIOPin?
    var pin7: MBLGPIOPin?
    
    //Create an array of the sensor states
    let sensorChoice: [SensorToRead] = [.sensor1, .sensor2, .sensor3, .sensor4, .sensor5, .sensor6, .sensor7]

    
    // This is the function that connects to the device
    // The closure is to update the text title with an indication that the device is connected
    func getDevice(updateText: () -> ()) {
        print("Starting to Search")
        // I find it weird that connecting is in the closure for finding, but we'll see if it works
        metaWearManager.startScanForMetaWearsWithHandler({(array: [AnyObject]?) -> Void in
            self.devices = array as? [MBLMetaWear]
            for cur in self.devices! {
                cur.rememberDevice()
                self.metaWearManager.stopScanForMetaWears()
                
                self.device = cur
                print(self.device)
                print(self.device?.state.rawValue)
                self.device?.connectWithHandler { (error: NSError?) -> Void in
                    //self.device?.led?.flashLEDColorAsync(UIColor.redColor(), withIntensity:  0.5)
                    print("We are connected")
                    updateText()
                }
            }
        })
    }
    
    // This enumeration is for the pin states ... And therefore to update the sensor choice
    enum SensorToRead: String {
        case sensor1
        case sensor2
        case sensor3
        case sensor4
        case sensor5
        case sensor6
        case sensor7
    }
    
    func getVoltageAllSensors(pin0: MBLGPIOPin) {
        for i in sensorChoice {
            switch i {
            case .sensor1:
                pin4?.configuration = MBLPinConfiguration.Pulldown
                pin6?.configuration = MBLPinConfiguration.Pulldown
                pin7?.configuration = MBLPinConfiguration.Pulldown
                pin0.analogAbsolute.readAsync().success( { (result: AnyObject?) in
                    if let voltage = result as? MBLNumericData {
                        self.voltageData1.append(Double(voltage.value))
                        print("Sensor 1 voltage \(voltage.value)")
                    }
                })
            
            case .sensor2:
                pin4?.configuration = MBLPinConfiguration.Pullup
                pin6?.configuration = MBLPinConfiguration.Pulldown
                pin7?.configuration = MBLPinConfiguration.Pulldown
                pin0.analogAbsolute.readAsync().success( { (result: AnyObject?) in
                    if let voltage = result as? MBLNumericData {
                        self.voltageData1.append(Double(voltage.value))
                        print("Sensor 1 voltage \(voltage.value)")
                    }
                })
            
            case .sensor3:
                pin4?.configuration = MBLPinConfiguration.Pullup
                pin6?.configuration = MBLPinConfiguration.Pullup
                pin7?.configuration = MBLPinConfiguration.Pulldown
                pin0.analogAbsolute.readAsync().success( { (result: AnyObject?) in
                    if let voltage = result as? MBLNumericData {
                        self.voltageData1.append(Double(voltage.value))
                        print("Sensor 1 voltage \(voltage.value)")
                    }
                })
            
            case .sensor4:
                pin4?.configuration = MBLPinConfiguration.Pulldown
                pin6?.configuration = MBLPinConfiguration.Pulldown
                pin7?.configuration = MBLPinConfiguration.Pullup
                pin0.analogAbsolute.readAsync().success( { (result: AnyObject?) in
                    if let voltage = result as? MBLNumericData {
                        self.voltageData1.append(Double(voltage.value))
                        print("Sensor 1 voltage \(voltage.value)")
                    }
                })
            
            case .sensor5:
                pin4?.configuration = MBLPinConfiguration.Pullup
                pin6?.configuration = MBLPinConfiguration.Pulldown
                pin7?.configuration = MBLPinConfiguration.Pullup
                pin0.analogAbsolute.readAsync().success( { (result: AnyObject?) in
                    if let voltage = result as? MBLNumericData {
                        self.voltageData1.append(Double(voltage.value))
                        print("Sensor 1 voltage \(voltage.value)")
                    }
                })
            
            case .sensor6:
                pin4?.configuration = MBLPinConfiguration.Pulldown
                pin6?.configuration = MBLPinConfiguration.Pullup
                pin7?.configuration = MBLPinConfiguration.Pullup
                pin0.analogAbsolute.readAsync().success( { (result: AnyObject?) in
                    if let voltage = result as? MBLNumericData {
                        self.voltageData1.append(Double(voltage.value))
                        print("Sensor 1 voltage \(voltage.value)")
                    }
                })
            
            case .sensor7:
                pin4?.configuration = MBLPinConfiguration.Pullup
                pin6?.configuration = MBLPinConfiguration.Pullup
                pin7?.configuration = MBLPinConfiguration.Pullup
                pin0.analogAbsolute.readAsync().success( { (result: AnyObject?) in
                    if let voltage = result as? MBLNumericData {
                        self.voltageData1.append(Double(voltage.value))
                        print("Sensor 1 voltage \(voltage.value)")
                    }
                })
            }
        }
    }
    
    
    //This is the function that will get the values
    //The closure is used to update the graph with the new values
    func getValues(updateGraph: () -> ()) {
        // Confirm we making the graph start
        print("We getting this shit")
        
        // Digital Pin Shit
        guard device?.gpio?.pins != nil else {
            print("We done goofed")
            return
        }
        //Define these pins for the future
        let pin4: MBLGPIOPin = device?.gpio?.pins[4] as! MBLGPIOPin
        let pin6: MBLGPIOPin = device?.gpio?.pins[6] as! MBLGPIOPin
        let pin7: MBLGPIOPin = device?.gpio?.pins[7] as! MBLGPIOPin
        let pin0: MBLGPIOPin = device?.gpio?.pins[0] as! MBLGPIOPin
        
        //Here is the experimental code
        //Just trying to see if I can get all the pins to work
        //Might try the notifications in the future if I can win it
        getVoltageAllSensors(pin0)
        
        // Take Pin Reading and get some numbers
        // This is the code that works for the graph
        pin4.configuration = MBLPinConfiguration.Pullup
        pin6.configuration = MBLPinConfiguration.Pulldown
        pin7.configuration = MBLPinConfiguration.Pulldown
        let periodicPinValue: MBLEvent? = pin0.analogAbsolute.periodicReadWithPeriod(100)
        periodicPinValue?.startNotificationsWithHandlerAsync({(obj: AnyObject?, error: NSError?) in
            if let voltage = obj as? MBLNumericData {
                self.voltageData.append(Double(voltage.value))
                updateGraph()
            }
        })
        

    }


}


