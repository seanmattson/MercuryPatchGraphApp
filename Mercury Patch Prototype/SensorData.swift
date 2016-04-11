//
//  SensorData.swift
//  Mercury Patch Prototype
//
//  Created by Sean Mattson on 3/30/16.
//  Copyright © 2016 Sean Mattson. All rights reserved.
//

import Foundation

class SensorData {
    var sensorName: String
    let setData = SetChartData()
    var pressureAvg: Double?
    
    var sensorVoltageReadings = [Double]() {
        didSet {
            setData.dataAdded(sensorVoltageReadings)
        }
    }
    
    init(_ name: String) {
        sensorName = name
    }
    
    func howMuchPressure() {
        let pastPressure = self.sensorVoltageReadings.reduce(0) {
            return ($0 + $1)
        }
        self.pressureAvg = pastPressure/Double(self.sensorVoltageReadings.count)
    }
    
}
