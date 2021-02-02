//
//  DashboardTableCell.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 1.02.2021.
//

import UIKit
import Charts

class DashboardTableCell: UITableViewCell, ChartViewDelegate, IAxisValueFormatter {
    
    let months = ["Jan", "Feb", "Mar",
                  "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep",
                  "Oct", "Nov", "Dec"]
    
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
        chartView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(chartView)
        chartView.setAnchorConstraintsEqualTo(widthAnchor: nil, heightAnchor: nil,
                                              topAnchor: (self.topAnchor, 40),
                                              bottomAnchor: (self.bottomAnchor, -20),
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
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMinimum = 0
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bothSided
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        
        chartView.rightAxis.enabled = false
        
        chartView.legend.form = .circle
    
        
        chartView.animate(xAxisDuration: 2.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setLineDataCount(_ count: Int, range: UInt32) {
        let now = Date().timeIntervalSince1970
        let hourSeconds: TimeInterval = 3600
        
        let from = now - (Double(count) / 2) * hourSeconds
        let to = now + (Double(count) / 2) * hourSeconds
        
        let values = stride(from: from, to: to, by: hourSeconds).map { (x) -> ChartDataEntry in
            let y = arc4random_uniform(range) + 50
            return ChartDataEntry(x: x, y: Double(y))
        }
        
        let values2 = stride(from: from, to: to, by: hourSeconds).map { (x) -> ChartDataEntry in
            let y = arc4random_uniform(range) + 50
            return ChartDataEntry(x: x, y: Double(y))
        }
        
        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        set1.axisDependency = .left
        set1.setColor(SPNativeColors.yellow)
        set1.lineWidth = 1.5
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.fillAlpha = 0.26
        set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        let set2 = LineChartDataSet(entries: values2, label: "DataSet 2")
        set2.axisDependency = .left
        set2.setColor(SPNativeColors.red)
        set2.lineWidth = 1.5
        set2.drawCirclesEnabled = false
        set2.drawValuesEnabled = false
        set2.fillAlpha = 0.26
        set2.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set2.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set2.drawCircleHoleEnabled = false
        
        
//        let data = LineChartData(dataSet: set1)
        let data = LineChartData(dataSets: [set1, set2])

        data.setValueTextColor(.purple)
        data.setValueFont(.systemFont(ofSize: 9, weight: .light))
        
        
        chartView.data = data
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 24)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let yVals2 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 41)
            return ChartDataEntry(x: Double(i), y: val)
        }

        let set1: LineChartDataSet = LineChartDataSet(entries: yVals1, label: "Aksesuar")

        set1.axisDependency = .left
        set1.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
        set1.setCircleColor(.red)
        set1.lineWidth = 2
        set1.circleRadius = 3
        set1.mode = .cubicBezier
        set1.fillAlpha = 65/255
        set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = true

        let set2: LineChartDataSet = LineChartDataSet(entries: yVals2, label: "TELKO")

        set2.axisDependency = .right
        set2.setColor(.red)
        set2.setCircleColor(.blue)
        set2.lineWidth = 2
        set2.circleRadius = 3
        set2.fillAlpha = 65/255
        set2.mode = .cubicBezier
        set2.fillColor = .red
        set2.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set2.drawCircleHoleEnabled = true

        let lineChartData = LineChartData(dataSets: [set1, set2])

        lineChartData.setValueTextColor(SPNativeColors.black)
        lineChartData.setValueFont(.systemFont(ofSize: 9))

        chartView.data = lineChartData
//
//        let data = CombinedChartData()
//        data.lineData = generateLineData(count:count)
//
        chartView.xAxis.axisMaximum = lineChartData.xMax + 0.25
//
//        chartView.data = data
    }
    
    
    private func setupView() {
        self.backgroundColor = SPNativeColors.white
    }
    
    func generateLineData(count: Int) -> LineChartData {
        let entries = (0..<count).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i) + 0.5, y: Double(arc4random_uniform(15) + 5))
        }
        
        let set = LineChartDataSet(entries: entries, label: "Line DataSet")
        set.setColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.lineWidth = 2.5
        set.setCircleColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.circleRadius = 5
        set.circleHoleRadius = 2.5
        set.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        set.mode = .cubicBezier
        set.drawValuesEnabled = true
        set.valueFont = .systemFont(ofSize: 10)
        set.valueTextColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        
        set.axisDependency = .left
        
        return LineChartData(dataSet: set)
    }
    
    
    
}

extension DashboardTableCell {
    static let identifier = "DashboardTableCell"
}

//
//public class DateValueFormatter: NSObject, AxisValueFormatter {
//    private let dateFormatter = DateFormatter()
//
//    override init() {
//        super.init()
//        dateFormatter.dateFormat = "dd MMM HH:mm"
//    }
//
//    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
//    }
//}
