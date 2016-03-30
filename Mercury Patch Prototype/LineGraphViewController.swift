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
    var bluetooth = MetaWearBluetoothObjC()
    
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var sensorButton:UIBarButtonItem!
    @IBOutlet weak var graphTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.delegate = self
        lineChartView.descriptionText = ""
        lineChartView.gridBackgroundColor = UIColor.darkGrayColor()
        lineChartView.dragEnabled = true
        
        lineChartView.noDataText = "The patch is not hooked up"
        bluetooth.getDevice{
            self.graphTitle.text = "Patch is connected"
        }
        
        // This code block is for the sidemenu reveal
        if self.revealViewController() != nil {
            sensorButton.target = self.revealViewController()
            sensorButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        

    }
    
    func setChartData() {
        
        setData.dataAdded(bluetooth.voltageData)
        
        let data: LineChartData = LineChartData(xVals: [Int](count: setData.set.entryCount, repeatedValue: 1), dataSet: setData.set)
        lineChartView.data = data
        
        lineChartView.setVisibleXRangeMaximum(100)
        lineChartView.moveViewToX(CGFloat((setData.set.entryCount)))

    }
    
    
    @IBAction func startStreaming(sender: AnyObject) {
        bluetooth.getValues{
            self.setData.dataAdded(self.bluetooth.voltageData)
            
            
            let data: LineChartData = LineChartData(xVals: [Int](count: self.setData.set.entryCount, repeatedValue: 1), dataSet: self.setData.set)
            self.lineChartView.data = data
            
            self.lineChartView.setVisibleXRangeMaximum(100)
            self.lineChartView.moveViewToX(CGFloat((self.setData.set.entryCount)))
            
        }
    }
    
    @IBAction func stopStreaming(sender: AnyObject) {
        bluetooth.periodicPinValue?.stopNotificationsAsync()

    }
    
}
