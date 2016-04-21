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

    var setData = SetChartData()
    var timer = NSTimer()
    let bluetooth = MetaWearBluetoothObjC.sharedInstance
    var sensorReading: SensorData?
    var sensorWeReading: Int!
    var yAxis: ChartYAxis?
    
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var graphTitle: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.delegate = self
        lineChartView.descriptionText = ""
        lineChartView.gridBackgroundColor = UIColor.darkGrayColor()
        lineChartView.dragEnabled = true
        
        //Trying out to see if force constant axes
        yAxis = lineChartView.getAxis(ChartYAxis.AxisDependency.Left)
        
        lineChartView.noDataText = "The patch is not hooked up"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        bluetooth.getValues{
            
            //Trying to set axis values
            self.yAxis?.axisMaximum = 3.00
            self.yAxis?.axisMinimum = -0.1
            
            let sensorDataSet = self.bluetooth.sensorArray[self.sensorWeReading].setData.set
            let data: LineChartData = LineChartData(xVals: [Int](count: sensorDataSet.entryCount, repeatedValue: 1), dataSet: sensorDataSet)
            self.lineChartView.data = data
            
            self.lineChartView.setVisibleXRangeMaximum(100)
            self.lineChartView.moveViewToX(CGFloat((sensorDataSet.entryCount)))
            print(Int(sensorDataSet.entryCount))
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        self.bluetooth.periodicPinValue?.stopNotificationsAsync()
    }
    
    
    
    /*func getAverages() -> Int {
        var findMaxPressureAvg = [Double]()
        for i in self.bluetooth.sensorArray {
            i.howMuchPressure()
            if let j = i.pressureAvg {
                findMaxPressureAvg.append(j)
            }
        }
        let arrayMax = findMaxPressureAvg.maxElement()
        for k in 0 ..< findMaxPressureAvg.count {
            if arrayMax == findMaxPressureAvg[k]{
                return k
            }
        }
        return 0
    }
    
   @IBAction func startStreaming(sender: AnyObject) {
        bluetooth.getValues{
            let sensorDataSet = self.bluetooth.sensorArray[self.sensorWeReading].setData.set
            let data: LineChartData = LineChartData(xVals: [Int](count: sensorDataSet.entryCount, repeatedValue: 1), dataSet: sensorDataSet)
            self.lineChartView.data = data
            
            self.lineChartView.setVisibleXRangeMaximum(100)
            self.lineChartView.moveViewToX(CGFloat((self.setData.set.entryCount)))

        }
    }*/
    
    @IBAction func stopStreaming(sender: AnyObject) {
        bluetooth.periodicPinValue?.stopNotificationsAsync()

    }
    
    /*@IBAction func changeSensorReading(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.sensorWeReading = 0
        case 1:
            self.sensorWeReading = 1
        case 2:
            self.sensorWeReading = 2
        case 3:
            self.sensorWeReading = 3
        case 4:
            self.sensorWeReading = 4
        case 5:
            self.sensorWeReading = 5
        case 6:
            self.sensorWeReading = 6
        default:
            print("Sensor is not there")
            return
        }
    }*/
    
}
