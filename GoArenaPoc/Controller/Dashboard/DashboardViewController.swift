//
//  SettingsViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 27.01.2021.
//

import UIKit

//struct ProductGroupName:Codable {

class DashboardViewController: ViewController {

    var tableView = UITableView()

    var usertChart:[DashboardChart] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        setupView()
        getUserDashboardChartData()

    }
    
    func getUserDashboardChartData() {
        guard let userId = User.currentUser()?.id else { return }
        self.showLoading()
        self.networkManager.sendRequest(route: .dashboardChartUser(userId: 14), [DashboardChart].self) {[weak self] (result, error) in
            guard let self = self else { return }
            if let _ = error {
                DispatchQueue.main.async {
                    self.hideLoading()
                }
            }
            if let result = result {
                self.usertChart = result.data ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.hideLoading()
                }
            }
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BarChartTableViewCell.identifier, for: indexPath) as! BarChartTableViewCell
            cell.contentView.isUserInteractionEnabled = false
            cell.setData(data: self.usertChart)
            //cell.setDataCount(4, range: 4)
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: DashboardLineTableCell.identifier, for: indexPath) as! DashboardLineTableCell
            cell.contentView.isUserInteractionEnabled = false
            cell.setDataCount(5, range: 2)
            return cell
        }
    }
            
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 500//UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
