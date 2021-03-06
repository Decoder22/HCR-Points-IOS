//
//  HousePointsCompareView.swift
//  Platinum Points
//
//  Created by Brian Johncox on 7/21/18.
//  Copyright © 2018 DecodeProgramming. All rights reserved.
//

import UIKit
import Charts


class MyValueFormatter: IValueFormatter {
    
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return value.rounded(toPlaces: 2).description
    }
    
    
    

}

class HousePointsCompareView: UIView {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var chart: BarChartView!
    
    var houses = [House]()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("HousePointsCompareView", owner: self, options: nil)
        addSubview(backgroundView)
        backgroundView.frame = self.bounds
        backgroundView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        refreshDataSet()
    }
    
    func refreshDataSet(){
        houses = DataManager.sharedManager.getHouses()!
        let fourthplace = BarChartDataSet(values: [BarChartDataEntry(x: 1, y: houses[3].pointsPerResident)], label: houses[3].houseID)
        let secondPlace = BarChartDataSet(values: [BarChartDataEntry(x: 2, y: houses[1].pointsPerResident)], label: houses[1].houseID)
        let firstPlace = BarChartDataSet(values: [BarChartDataEntry(x: 3, y: houses[0].pointsPerResident)], label: houses[0].houseID)
        let thirdPlace = BarChartDataSet(values: [BarChartDataEntry(x: 4, y: houses[2].pointsPerResident)], label: houses[2].houseID)
        let fifthPlace = BarChartDataSet(values: [BarChartDataEntry(x: 5, y: houses[4].pointsPerResident)], label: houses[4].houseID)
        
        fourthplace.setColor(AppUtils.hexStringToUIColor(hex:houses[3].hexColor))
        secondPlace.setColor(AppUtils.hexStringToUIColor(hex:houses[1].hexColor))
        firstPlace.setColor(AppUtils.hexStringToUIColor(hex:houses[0].hexColor))
        thirdPlace.setColor(AppUtils.hexStringToUIColor(hex:houses[2].hexColor))
        fifthPlace.setColor(AppUtils.hexStringToUIColor(hex:houses[4].hexColor))
        
        firstPlace.valueFormatter = MyValueFormatter()
        secondPlace.valueFormatter = MyValueFormatter()
        thirdPlace.valueFormatter = MyValueFormatter()
        fourthplace.valueFormatter = MyValueFormatter()
        fifthPlace.valueFormatter = MyValueFormatter()
        
        
        let data = BarChartData(dataSets: [fourthplace,secondPlace,firstPlace,thirdPlace,fifthPlace])
        chart.chartDescription?.text = ""
        chart.data = data
        chart.drawGridBackgroundEnabled = false
        chart.xAxis.drawLabelsEnabled = false
        chart.leftAxis.axisMinimum = 0.0
        chart.rightAxis.axisMinimum = 0.0
        chart.isUserInteractionEnabled = false
        
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        chart.notifyDataSetChanged()
    }

    
    
}


