//
//  DynamicDataGenerator.swift
//  Mercury Patch Prototype
//
//  Created by Sean Mattson on 3/21/16.
//  Copyright © 2016 Sean Mattson. All rights reserved.
//

import Foundation
import Charts

class DynamicDataGenerator {
    var dataArray1 = [Double]()
    var dataArray2 = [Double]()
    var dataArray3 = [Double]()
    var dataArray4 = [Double]()
    var dataArray5 = [Double]()
    var dataArray6 = [Double]()
    var dataArray7 = [Double]()
    
    let sensorTypes: [ForceSensor] = [ .sensor1, .sensor2, .sensor3, .sensor4, .sensor5, .sensor6, .sensor7]
    
    enum ForceSensor: String {
        case sensor1 = "Sensor 1"
        case sensor2 = "Sensor 2"
        case sensor3 = "Sensor 3"
        case sensor4 = "Sensor 4"
        case sensor5 = "Sensor 5"
        case sensor6 = "Sensor 6"
        case sensor7 = "Sensor 7"
    }
    
    func addPoint() {
        let newPoint1 = Double(arc4random_uniform(140)) + 30.0
        let newPoint2 = Double(arc4random_uniform(40)) + 100.0
        let newPoint3 = Double(arc4random_uniform(60)) + 80.0
        let newPoint4 = Double(arc4random_uniform(40)) + 30.0
        let newPoint5 = Double(arc4random_uniform(140)) + 40.0
        let newPoint6 = Double(arc4random_uniform(90)) + 50.0
        let newPoint7 = Double(arc4random_uniform(70)) + 60.0
        
        for i in sensorTypes {
            switch i {
            case .sensor1:
                dataArray1.append(newPoint1)
                
            case .sensor2:
                dataArray2.append(newPoint2)
                
            case .sensor3:
                dataArray3.append(newPoint3)
                
            case .sensor4:
                dataArray4.append(newPoint4)
                
            case .sensor5:
                dataArray5.append(newPoint5)
                
            case .sensor6:
                dataArray6.append(newPoint6)
                
            case .sensor7:
                dataArray7.append(newPoint7)
            }
        }
    }
    
}
