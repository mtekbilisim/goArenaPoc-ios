//
//  BarChartTableViewCell.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import UIKit
import Charts

class BarChartTableViewCell: UITableViewCell, ChartViewDelegate, IAxisValueFormatter {
    
    let months = ["ocak","şubat","mart","nisan"]
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value) % months.count]
    }
           
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.negativeSuffix = ""
        formatter.positiveSuffix = ""
        return formatter
    }()
    
    var chartView: LineChartView!

    var shouldHideData: Bool = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        chartView =  LineChartView()
        chartView.roundTop(radius: 20)
        chartView.backgroundColor = UIColor.init(hex: "023953")
        chartView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(chartView)
        chartView.setAnchorConstraintsEqualTo(widthAnchor: nil, heightAnchor: nil,
                                              topAnchor: (self.topAnchor, 50),
                                              bottomAnchor: (self.bottomAnchor, 0),
                                              leadingAnchor: (self.leadingAnchor, 0),
                                              trailingAnchor: (self.trailingAnchor, 0))
//
        chartView.delegate = self
        
        let l = chartView.legend
        l.wordWrapEnabled = true
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
//        chartView.legend = l

        let rightAxis = chartView.rightAxis
        rightAxis.axisMinimum = 0
        rightAxis.labelFont = AppAppearance.eleven!
        rightAxis.labelTextColor = .white
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMinimum = 0
        leftAxis.labelFont = AppAppearance.eleven!
        leftAxis.labelTextColor = .white
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        xAxis.labelFont = AppAppearance.eleven!
        xAxis.labelTextColor = .white
        
        chartView.rightAxis.enabled = false
        chartView.legend.form = .square
        chartView.legend.textColor = .white
        chartView.legend.font = AppAppearance.eleven!
        chartView.animate(xAxisDuration: 2.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDataCount(_ count: Int, range: UInt32) {
//        let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
//            var val : Double = 0.0
//            if i == 0 {
//                val = 0.0
//            } else {
//                val = Double(arc4random_uniform(range) + 24)
//            }
//            return ChartDataEntry(x: Double(i), y: val)
//        }
//        let yVals2 = (0..<count).map { (i) -> ChartDataEntry in
//            var val : Double = 0.0
//            if i == 0 {
//                val = 0.0
//            } else {
//                val = Double(arc4random_uniform(range) + 79)
//            }
//            return ChartDataEntry(x: Double(i), y: val)
//        }
//
//        let set1: LineChartDataSet = LineChartDataSet(entries: yVals1, label: "Telefon")
//
//        set1.axisDependency = .left
//        set1.setColor(UIColor.init(hex: "059FE7"))
//        set1.setCircleColor(.white)
//        set1.lineWidth = 2
//        set1.circleRadius = 5
//        set1.mode = .cubicBezier
//        set1.fillAlpha = 1
//        set1.fillColor = SPNativeColors.pink
//        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
//        set1.drawCircleHoleEnabled = true
//
//        let set2: LineChartDataSet = LineChartDataSet(entries: yVals2, label: "Tablet")
//        set2.axisDependency = .right
//        set2.setColor(UIColor.init(hex: "F0E204"))
//        set2.setCircleColor(.white)
//        set2.lineWidth = 2
//        set2.circleRadius = 5
//        set2.fillAlpha = 65/255
//        set2.mode = .cubicBezier
//        set2.fillColor = .blue
//        set2.highlightColor = SPNativeColors.purple
//        set2.drawCircleHoleEnabled = true
//
//        let lineChartData = LineChartData(dataSets: [set1, set2])
//
//        lineChartData.setValueTextColor(SPNativeColors.white)
//        lineChartData.setValueFont(AppAppearance.thirteen!)
//
//        chartView.data = lineChartData
//        chartView.xAxis.axisMaximum = lineChartData.xMax + 0.25
    }
    
    
    private func setupView() {
        self.backgroundColor = .white//UIColor.init(hex: "FFFFFF")
        let chartTitleLabel = UILabel()
        chartTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        chartTitleLabel.text =  "Satışlar"
        chartTitleLabel.textColor = .black
        chartTitleLabel.font = UIFont(name: "TurkcellSatura", size: 32)
        self.addSubview(chartTitleLabel)
        chartTitleLabel.leading(16)
        chartTitleLabel.top(4)
    }
    
//    func generateLineData(count: Int) -> LineChartData {
//        let entries = (0..<count).map { (i) -> ChartDataEntry in
//            return ChartDataEntry(x: Double(i) + 0.5, y: Double(arc4random_uniform(15) + 5))
//        }
//
//        let set = LineChartDataSet(entries: entries, label: "Line DataSet")
//        set.setColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
//        set.lineWidth = 2.5
//        set.setCircleColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
//        set.circleRadius = 5
//        set.circleHoleRadius = 2.5
//        set.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
//        set.mode = .cubicBezier
//        set.drawValuesEnabled = true
//        set.valueFont = .systemFont(ofSize: 10)
//        set.valueTextColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
//
//        set.axisDependency = .left
//
//        return LineChartData(dataSet: set)
//    }
//
    
    
}

extension BarChartTableViewCell {
    static let identifier = "BarChartTableViewCell"
}


