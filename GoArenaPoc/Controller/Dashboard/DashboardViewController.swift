//
//  SettingsViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 27.01.2021.
//

import UIKit

class DashboardViewController: ViewController {

    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        setupView()
    }
}

extension DashboardViewController {
    private func setupView() {
        tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(DashboardTableCell.self, forCellReuseIdentifier: DashboardTableCell.identifier)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: DashboardTableCell.identifier, for: indexPath) as! DashboardTableCell
        cell.contentView.isUserInteractionEnabled = false
        if indexPath.row == 0 {
            //cell.setBarData(count: Int(12), range: UInt32(300))
        } else {
           // cell.setLineDataCount(Int(12), range: UInt32(300))
        }
        return cell
    }
            
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400//UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
