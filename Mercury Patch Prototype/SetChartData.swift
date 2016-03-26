//
//  ArrayToChartData.swift
//  Mercury Patch Prototype
//
//  Created by Sean Mattson on 3/22/16.
//  Copyright © 2016 Sean Mattson. All rights reserved.
//

import Foundation
import Charts

class SetChartData {
    var rawData: [Double]
    var yValues = [ChartDataEntry]()
    var set: LineChartDataSet
    
    init (data: [Double]) {
        rawData = data
        
        for i in 0 ... (rawData.count - 1) {
            yValues.append(ChartDataEntry(value: rawData[i], xIndex: i))
        }
        set = LineChartDataSet(yVals: yValues, label: "Pressure")
        set.axisDependency = .Left
        set.setColor(UIColor.redColor())
        set.lineWidth = 2.0
        set.drawCirclesEnabled = false
        set.drawValuesEnabled = false
        set.drawCubicEnabled = true
        set.drawFilledEnabled = true
    }
    
    func dataAdded(newDataArray: [Double]) {
        let newPoint = newDataArray.last!
        let newIndex = newDataArray.count - 1
        let newData = ChartDataEntry(value: newPoint, xIndex: newIndex)
        set.addEntry(newData)
    }

    
}
