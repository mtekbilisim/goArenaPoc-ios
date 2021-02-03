//
//  BarChartTableViewCell.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import UIKit
import Charts

class BarChartTableViewCell: UITableViewCell, ChartViewDelegate {
     
    var months = ["Jan", "Feb", "Mar", "Apr", "May"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0]
    let unitsBought = [10.0, 14.0, 60.0, 13.0, 2.0]
    
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.negativeSuffix = ""
        formatter.positiveSuffix = ""
        return formatter
    }()
    
    var barChartView =  BarChartView()

    var shouldHideData: Bool = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.backgroundColor = .white//UIColor.init(hex: "FFFFFF")
        let chartTitleLabel = UILabel()
        chartTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        chartTitleLabel.text =  "Satışlar - Cihaz"
        chartTitleLabel.textColor = .black
        chartTitleLabel.font = UIFont(name: "TurkcellSatura", size: 32)
        self.addSubview(chartTitleLabel)
        chartTitleLabel.leading(16)
        chartTitleLabel.top(4)
        
        barChartView =  BarChartView()
        barChartView.roundTop(radius: 20)
        barChartView.backgroundColor = .white//UIColor.init(hex: "023953")
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(barChartView)
        
        barChartView.setAnchorConstraintsEqualTo(widthAnchor: nil, heightAnchor: nil,
                                              topAnchor: (self.topAnchor, 50),
                                              bottomAnchor: (self.bottomAnchor, 0),
                                              leadingAnchor: (self.leadingAnchor, 0),
                                              trailingAnchor: (self.trailingAnchor, 0))
        barChartView.delegate = self

    }
    
    func setData(data: [DashboardChart]) {
        
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = false
        
        barChartView.maxVisibleCount = 60
        
        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        
        
        let yaxis = barChartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        
        barChartView.rightAxis.enabled = false
        barChartView.delegate = self
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.chartDescription?.textColor = UIColor.clear
        
        let xaxis = barChartView.xAxis
        //xaxis.valueFormatter = axisFormatDelegate
        xaxis.forceLabelsEnabled = true
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .top
        xaxis.centerAxisLabelsEnabled = true
        //xaxis.valueFormatter = IndexAxisValueFormatter(values:self.months)
        xaxis.granularityEnabled = true
        xaxis.granularity = 5
        
        let defaultProduct:String = "Cihaz"
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
       let filteredData = data.filter{($0.product_group==defaultProduct)}
        
        var xAxisData:[String] = []
        
        for i in 0..<filteredData.count {
            xAxisData.append(filteredData[i].employee)
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(filteredData[i].sales))
            dataEntries.append(dataEntry)
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: Double(filteredData[i].expectation))
            dataEntries1.append(dataEntry1)
        }
        
        #if DEBUG
        print(xAxisData)
        #endif
        xaxis.valueFormatter = IndexAxisValueFormatter(values:xAxisData)

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Satış")
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Hedef")
        
        let dataSets: [BarChartDataSet] = [chartDataSet, chartDataSet1]
        chartDataSet.colors = [UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.5)]
        chartDataSet1.colors = [UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.8)]

        let chartData = BarChartData(dataSets: dataSets)
        let groupSpace = 0.63
        let barSpace = 0.05
        let barWidth = groupSpace
        
        let groupCount = xAxisData.count
        let startYear = 0
        
        chartData.barWidth = barWidth;
        barChartView.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barChartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        barChartView.data = chartData
        barChartView.setVisibleXRangeMaximum(15)
        barChartView.animate(yAxisDuration: 1.0, easingOption: .easeInOutBounce)
    }
    
    
}

extension BarChartTableViewCell {
    static let identifier = "BarChartTableViewCell"
}


