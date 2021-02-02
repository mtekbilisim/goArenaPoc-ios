//
//  SettingsViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 27.01.2021.
//

import UIKit

class DashboardViewController: ViewController {

    var tableView = UITableView()
    var sales:[Sale] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        setupView()
        
        getSalesForEmployee()
    }
    
    func getSalesForEmployee() {
        networkManager.sendRequest(route: .employeeSalesWithShopId, [Sale].self) { [weak self] (result, error) in
            guard let self = self else { return }
            
        }
    }
}

extension DashboardViewController {
    private func setupView() {
        tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear//UIColor.init(hex: "023953")
        tableView.register(DashboardLineTableCell.self, forCellReuseIdentifier: DashboardLineTableCell.identifier)
        tableView.register(BarChartTableViewCell.self, forCellReuseIdentifier: BarChartTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.setAnchorConstraintsFullSizeTo(view: view, padding: 0)
    }
}

extension DashboardViewController:UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BarChartTableViewCell.identifier, for: indexPath) as! BarChartTableViewCell
            cell.contentView.isUserInteractionEnabled = false
            cell.setDataCount(4, range: 4)
            return cell
        } else  if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: DashboardLineTableCell.identifier, for: indexPath) as! DashboardLineTableCell
            cell.contentView.isUserInteractionEnabled = false
            cell.setDataCount(5, range: 31)
            return cell
        } else {
            return UITableViewCell()
        }
    }
            
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return CGFloat(sales.count > 0 ? sales.count * 60 : 0)
        } else {
            return 500//UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
