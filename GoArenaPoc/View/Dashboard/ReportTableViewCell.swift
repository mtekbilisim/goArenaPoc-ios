//
//  ReportTableViewCell.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import UIKit

class ReportTableViewCell: UITableViewCell {
    
    var tableView = UITableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        tableView.setAnchorConstraintsFullSizeTo(view: self)
    }
    
}
