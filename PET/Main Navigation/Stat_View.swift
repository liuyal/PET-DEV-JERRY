//
//  Stat_View.swift
//  PET
//
//  Created by liuyal on 11/21/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Charts

class Stat_View: UIViewController {
    
    //Reference to FireDataBase
    var ref: DatabaseReference!
    
    // User object for passing of object between views
    var user: User_Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Reference to Firebase Database
        ref = Database.database().reference()
        let emotionIDA: [emotionID] = [.happy, .sad, .scared, .angry, .surprised, .inlove, .confused, .shy, .excited, .sick, .confident, .embarrassed]
        
        //let emotionIDS = ["happy", "sad", "scared", "angry", "surprised", "inlove", "confused", "shy", "excited", "sick", "confident", "embarrassed"]
        
        var ErrorStats = Array(repeating: 0, count: DeckSize)
        
        for i in 0..<TIER_SIZE*Q_PER_TIER{
            
            if user?.progress.questionArray[i].emotion == emotionIDA[0]{
                ErrorStats[0] += (user?.progress.questionArray[i].errCnt)!
            }
            else if user?.progress.questionArray[i].emotion == emotionIDA[1]{
                ErrorStats[1] += (user?.progress.questionArray[i].errCnt)!
            }
            else if user?.progress.questionArray[i].emotion == emotionIDA[2]{
                ErrorStats[2] += (user?.progress.questionArray[i].errCnt)!
            }
            else if user?.progress.questionArray[i].emotion == emotionIDA[3]{
                ErrorStats[3] += (user?.progress.questionArray[i].errCnt)!
            }
            else if user?.progress.questionArray[i].emotion == emotionIDA[4]{
                ErrorStats[4] += (user?.progress.questionArray[i].errCnt)!
            }
            else if user?.progress.questionArray[i].emotion == emotionIDA[5]{
                ErrorStats[5] += (user?.progress.questionArray[i].errCnt)!
            }
            else if user?.progress.questionArray[i].emotion == emotionIDA[6]{
                ErrorStats[6] += (user?.progress.questionArray[i].errCnt)!
            }
            else if user?.progress.questionArray[i].emotion == emotionIDA[7]{
                ErrorStats[7] += (user?.progress.questionArray[i].errCnt)!
            }
            else if user?.progress.questionArray[i].emotion == emotionIDA[8]{
                ErrorStats[8] += (user?.progress.questionArray[i].errCnt)!
            }
            else if user?.progress.questionArray[i].emotion == emotionIDA[9]{
                ErrorStats[9] += (user?.progress.questionArray[i].errCnt)!
            }
            else if user?.progress.questionArray[i].emotion == emotionIDA[10]{
                ErrorStats[10] += (user?.progress.questionArray[i].errCnt)!
            }
            else if user?.progress.questionArray[i].emotion == emotionIDA[11]{
                ErrorStats[11] += (user?.progress.questionArray[i].errCnt)!
            }
        }
        let entry0 = BarChartDataEntry(x: 1.0, y: Double(ErrorStats[0]))
        let entry1 = BarChartDataEntry(x: 2.0, y: Double(ErrorStats[1]))
        let entry2 = BarChartDataEntry(x: 3.0, y: Double(ErrorStats[2]))
        let entry3 = BarChartDataEntry(x: 4.0, y: Double(ErrorStats[3]))
        
        let entry4 = BarChartDataEntry(x: 5.0, y: Double(ErrorStats[4]))
        let entry5 = BarChartDataEntry(x: 6.0, y: Double(ErrorStats[5]))
        let entry6 = BarChartDataEntry(x: 7.0, y: Double(ErrorStats[6]))
        let entry7 = BarChartDataEntry(x: 8.0, y: Double(ErrorStats[7]))
        
        let entry8 = BarChartDataEntry(x: 9.0, y: Double(ErrorStats[8]))
        let entry9 = BarChartDataEntry(x: 10.0, y: Double(ErrorStats[9]))
        let entry10 = BarChartDataEntry(x: 11.0, y: Double(ErrorStats[10]))
        let entry11 = BarChartDataEntry(x: 12.0, y: Double(ErrorStats[11]))
        
        let dataSet = BarChartDataSet(values: [entry0, entry1, entry2, entry3, entry4, entry5, entry6, entry7, entry8, entry9, entry10, entry11], label: "Error Count")
        //let dataSet = BarChartDataSet(values: [entry0, entry1, entry2, entry3], label: "Error Count")
        let data = BarChartData(dataSets: [dataSet])
        data.setDrawValues(false)
        dataSet.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]

        bar.backgroundColor = UIColor.clear
        bar.noDataTextColor = UIColor.clear
        bar.noDataText = ""
        
        //All other additions to this function
        
        bar.xAxis.labelPosition = .bottom
        bar.xAxis.labelTextColor = UIColor.white
        bar.xAxis.labelFont = UIFont.systemFont(ofSize: 30)
        bar.xAxis.drawLabelsEnabled = false
        bar.xAxis.drawGridLinesEnabled = false
        bar.xAxis.gridColor = UIColor.white
        bar.xAxis.granularityEnabled = true
        bar.xAxis.granularity = 1.0 //default granularity is 1.0, but it is better to be explicit
        bar.xAxis.decimals = 0
        
        bar.rightAxis.enabled = false
        bar.leftAxis.labelTextColor = UIColor.white
        bar.leftAxis.drawLabelsEnabled = true
        bar.leftAxis.drawGridLinesEnabled = false
        bar.leftAxis.axisMinimum = 0
        bar.leftAxis.labelFont = UIFont.systemFont(ofSize: 30)
        bar.leftAxis.granularityEnabled = true
        bar.leftAxis.granularity = 1.0 //default granularity is 1.0, but it is better to be explicit
        bar.leftAxis.decimals = 0
        let leftAxisFormatter = NumberFormatter()
        let leftAxis = bar.leftAxis
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        
        bar.legend.enabled = false
        bar.data = data
        bar.chartDescription?.text = ""
        //This must stay at end of function
        bar.notifyDataSetChanged()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bar.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
        
    }
    
    @IBOutlet weak var bar: BarChartView!
    
    @IBAction func backSetting(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segStatback", sender: self)
    }
    
    // Function: overrider prepare() to allow for sending of variables to other view controllers
    // Input:
    //      1. for segue: UIStoryboardSegue
    //      2. sender: Any
    // Ouput: N/A
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send_user = user
        if let destinationViewController = segue.destination as? Setting_View {
            destinationViewController.user = send_user
        }
    }
}

public class IntAxisValueFormatter: NSObject, IAxisValueFormatter {
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value))"
    }
}


