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
    
    var pressureGenerator = DynamicDataGenerator()
    var setData = SetChartData()
    var timer = NSTimer()
    
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
        
        pressureGenerator.addPoint()
        setData.dataAdded(pressureGenerator.dataArray1)
        
        
        let data: LineChartData = LineChartData(xVals: [Int](count: setData.set.entryCount, repeatedValue: 1), dataSet: setData.set)
        lineChartView.data = data
        
        lineChartView.setVisibleXRangeMaximum(10)
        lineChartView.moveViewToX(CGFloat((setData.set.entryCount)))
        
        /* print("Array 2 is \(pressureGenerator.dataArray2)")
        print("Array 3 is \(pressureGenerator.dataArray3)")
        print("Array 4 is \(pressureGenerator.dataArray4)")
        print("Array 5 is \(pressureGenerator.dataArray5)")
        print("Array 6 is \(pressureGenerator.dataArray6)")
        print("Array 7 is \(pressureGenerator.dataArray7)") */

    }
    
    
    @IBAction func startStreaming(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(LineGraphViewController.setChartData), userInfo: nil, repeats: true)

    }
    
    @IBAction func stopStreaming(sender: AnyObject) {
        timer.invalidate()
    }
    
}
