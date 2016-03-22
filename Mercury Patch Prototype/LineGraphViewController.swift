//
//  LineGraphViewController.swift
//  Mercury Patch Prototype
//
//  Created by Sean Mattson on 3/21/16.
//  Copyright © 2016 Sean Mattson. All rights reserved.
//

import UIKit
import Charts

class LineGraphViewController: UIViewController, ChartViewDelegate {
    
    let pressureGenerator = DynamicDataGenerator()
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.delegate = self
        lineChartView.descriptionText = ""
        lineChartView.gridBackgroundColor = UIColor.darkGrayColor()
        
        lineChartView.noDataText = "The patch is not hooked up"
    }
    
    
    func setChartData() {
        var yVals: [ChartDataEntry] = [ChartDataEntry]()
        let pressure = pressureGenerator.dataArray
        
        for var i = 0; i < pressure.count; i++ {
            yVals.append(ChartDataEntry(value: pressure[i], xIndex: i))
        }
        
        let set: LineChartDataSet = LineChartDataSet(yVals: yVals, label: "First Test")
        
        set.axisDependency = .Left
        set.setColor(UIColor.redColor())
        set.lineWidth = 2.0
        set.drawCirclesEnabled = false
        set.drawValuesEnabled = false
        set.drawCubicEnabled = true
        
        let data: LineChartData = LineChartData(xVals: pressure, dataSet: set)
        
        lineChartView.data = data
        lineChartView.xAxis.labelPosition = .Bottom
    }
    
    
    @IBAction func fillInChart(sender: AnyObject) {
        setChartData()
        
    }
    
    @IBAction func addData(sender: AnyObject) {
        pressureGenerator.addPoint()
        setChartData()
    }
    
}
