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
    var setData: SetChartData?
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.delegate = self
        lineChartView.descriptionText = ""
        lineChartView.gridBackgroundColor = UIColor.darkGrayColor()
        lineChartView.dragEnabled = true
        
        lineChartView.noDataText = "The patch is not hooked up"
    }
    
    func setChartData() {
        setData = SetChartData(data: pressureGenerator.dataArray)
        let graphDataSet = setData!.set
        let data: LineChartData = LineChartData(xVals: setData!.rawData, dataSet: graphDataSet)
        
        lineChartView.data = data
    }
    
    
    @IBAction func fillInChart(sender: AnyObject) {
        setChartData()
        
    }
    
    @IBAction func addData(sender: AnyObject) {
        pressureGenerator.addPoint()
        setData?.dataAdded(pressureGenerator.dataArray)
        
        if let actuallyThere = (setData?.set.entryCount) {
            let data: LineChartData = LineChartData(xVals: [Int](count: actuallyThere, repeatedValue: 1), dataSet: setData?.set)
            lineChartView.data = data
        } else {
            return
        }
        lineChartView.setVisibleXRangeMaximum(10)
        lineChartView.moveViewToX(CGFloat((setData?.set.entryCount)!-10))

    }
    
}
