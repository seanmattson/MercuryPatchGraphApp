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
    var dataArray = [Double]()
    
    init() {
        for _ in 0...9 {
            let newPressure = Double(arc4random_uniform(140)) + 30.0
            dataArray.append(newPressure)
        }
    }
    
    func addPoint() {
        let newPoint = Double(arc4random_uniform(140)) + 30.0
        dataArray.append(newPoint)
    }
    
}
