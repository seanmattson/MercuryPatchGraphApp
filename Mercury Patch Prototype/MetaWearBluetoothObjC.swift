//
//  MetaWearBluetooth.swift
//  Mercury Patch Prototype
//
//  Created by Sean Mattson on 3/25/16.
//  Copyright © 2016 Sean Mattson. All rights reserved.
//

import Foundation

class MetaWearBluetoothObjC {
    
    // Allow all classes to refer to this instance
    static let sharedInstance = MetaWearBluetoothObjC()
    
    let metaWearManager = MBLMetaWearManager.sharedManager()
    var devices: [MBLMetaWear]?
    var device: MBLMetaWear?
    var periodicPinValue: MBLEvent?
    var bluetoothChip = "C"
    
    // Create the sensor data
    var Sensor0 = SensorData("Sensor 0")
    var Sensor1 = SensorData("Sensor 1")
    var Sensor2 = SensorData("Sensor 2")
    var Sensor3 = SensorData("Sensor 3")
    var Sensor4 = SensorData("Sensor 4")
    var Sensor5 = SensorData("Sensor 5")
    var Sensor6 = SensorData("Sensor 6")
    
    //Create an array of the sensor states
    var sensorArray: [SensorData]
    let sensorChoice: [SensorToRead] = [.sensor0, .sensor1, .sensor2, .sensor3, .sensor4, .sensor5, .sensor6/* .largeImpedance*/]
    
    private init() {
        self.sensorArray = [Sensor6, Sensor4, Sensor5, Sensor2, Sensor3, Sensor1, Sensor0]
    }

    
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
                self.device?.connectWithHandler { (error: NSError?) -> Void in
                    print("We are connected")
                    updateText()
                }
            }
        })
    }
    
    // This enumeration is for the pin states ... And therefore to update the sensor choice
    enum SensorToRead: String {
        case sensor0
        case sensor1
        case sensor2
        case sensor3
        case sensor4
        case sensor5
        case sensor6
        //case largeImpedance
    }
    
    func getVoltageAllSensors(pin4: MBLGPIOPin, pin6: MBLGPIOPin, pin7: MBLGPIOPin, numberSensor: Int) -> Int {
        var equationCount = numberSensor
        let i  = sensorChoice[numberSensor]
        switch i {
        case .sensor0:
            pin4.configuration = MBLPinConfiguration.Pulldown
            pin6.configuration = MBLPinConfiguration.Pulldown
            pin7.configuration = MBLPinConfiguration.Pulldown
            
            
        case .sensor1:
            pin4.configuration = MBLPinConfiguration.Pullup
            pin6.configuration = MBLPinConfiguration.Pulldown
            pin7.configuration = MBLPinConfiguration.Pulldown
            
            
        case .sensor2:
            pin4.configuration = MBLPinConfiguration.Pulldown
            pin6.configuration = MBLPinConfiguration.Pullup
            pin7.configuration = MBLPinConfiguration.Pulldown
            
            
        case .sensor3:
            pin4.configuration = MBLPinConfiguration.Pullup
            pin6.configuration = MBLPinConfiguration.Pullup
            pin7.configuration = MBLPinConfiguration.Pulldown
            
        case .sensor4:
            pin4.configuration = MBLPinConfiguration.Pulldown
            pin6.configuration = MBLPinConfiguration.Pulldown
            pin7.configuration = MBLPinConfiguration.Pullup
            
        case .sensor5:
            pin4.configuration = MBLPinConfiguration.Pullup
            pin6.configuration = MBLPinConfiguration.Pulldown
            pin7.configuration = MBLPinConfiguration.Pullup
            
        case .sensor6:
            pin4.configuration = MBLPinConfiguration.Pulldown
            pin6.configuration = MBLPinConfiguration.Pullup
            pin7.configuration = MBLPinConfiguration.Pullup
            
       /* case .largeImpedance:
            pin4.configuration = MBLPinConfiguration.Pullup
            pin6.configuration = MBLPinConfiguration.Pullup
            pin7.configuration = MBLPinConfiguration.Pullup */
            
        }
        
        if equationCount < self.sensorChoice.count - 1 {
            equationCount += 1
            return equationCount
        } else {
            return 0
        }
    }
    
    
    //This is the function that will get the values
    //The closure is used to update the graph with the new values
    func getValues(updateGraph: () -> ()) {
        
        var pin0: MBLGPIOPin?
        var pin6: MBLGPIOPin?
        var pin7: MBLGPIOPin?
        var pin4: MBLGPIOPin?
        
        // Make sure the bluetooth device is connected
        guard device?.gpio?.pins != nil else {
            print("We done goofed")
            return
        }
        
        //Define these pins
        // C pins
        if bluetoothChip == "C" {
            pin4 = device?.gpio?.pins[2] as? MBLGPIOPin
            pin6 = device?.gpio?.pins[1] as? MBLGPIOPin
            pin7 = device?.gpio?.pins[0] as? MBLGPIOPin
            pin0 = device?.gpio?.pins[3] as? MBLGPIOPin
            print("C chip")
        } else {
            pin4 = device?.gpio?.pins[4] as? MBLGPIOPin
            pin6 = device?.gpio?.pins[6] as? MBLGPIOPin
            pin7 = device?.gpio?.pins[7] as? MBLGPIOPin
            pin0 = device?.gpio?.pins[0] as? MBLGPIOPin
            print("R chip")
        }
        
        var j = 0
        periodicPinValue = pin0!.analogAbsolute.periodicReadWithPeriod(150)
        periodicPinValue?.startNotificationsWithHandlerAsync({(obj: AnyObject?, error: NSError?) in
            //Cases are defined as actual sensor number + 1, except for 7 which is 0
            //This is due to the how I numbered is in the get voltage all sensors equation
            if let voltage = obj as? MBLNumericData {
                switch j {
                case 1:
                    self.Sensor0.sensorVoltageReadings.append(Double(voltage.value))
                case 2:
                    self.Sensor1.sensorVoltageReadings.append(Double(voltage.value))
                case 3:
                    self.Sensor2.sensorVoltageReadings.append(Double(voltage.value))
                case 4:
                    self.Sensor3.sensorVoltageReadings.append(Double(voltage.value))
                case 5:
                    self.Sensor4.sensorVoltageReadings.append(Double(voltage.value))
                case 6:
                    self.Sensor5.sensorVoltageReadings.append(Double(voltage.value))
                
                case 0:
                    self.Sensor6.sensorVoltageReadings.append(Double(voltage.value)) 
                
                // If we do a large impedance to normalize multiplexer, we use this
               /*case 7:
                    self.Sensor6.sensorVoltageReadings.append(Double(voltage.value))
                case 0:
                    break*/
                
                default:
                    print("No sensor there")
                }
                print("We see sensor \(j) with value \(Double(voltage.value)) at time \(NSDate())")
            }
            updateGraph()
            j = self.getVoltageAllSensors(pin4!, pin6: pin6!, pin7: pin7!, numberSensor: j)
            print("Sensor Changed")
            
        })

    }


}


