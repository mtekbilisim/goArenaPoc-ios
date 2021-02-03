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
   
    var orderedChartDataArray:[DashboardChart] = []
    
    var shopChart:[ShopChart] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        setupView()
        getUserDashboardChartData()

    }
    
    func getUserDashboardChartData() {
        guard let userId = User.currentUser()?.id else { return }
        self.showLoading()
        self.networkManager.sendRequest(route: .dashboardChartUser(userId: userId), [DashboardChart].self) {[weak self] (result, error) in
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
    
    func dashboardChartShop() {
        guard let shopId = User.currentUser()?.shopId else { return }

        self.networkManager.sendRequest(route: .dashboardChartShop(shopId: shopId), [ShopChart].self) {[weak self] (result, error) in
            guard let self = self else { return }
            if let _ = error {
                DispatchQueue.main.async {
                    self.hideLoading()
                }
            }
            if let result = result {
                self.shopChart = result.data ?? []
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
        tableView.register(ProductGroupCell.self, forCellReuseIdentifier: ProductGroupCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.setAnchorConstraintsFullSizeTo(view: view, padding: 0)
    }
}

extension DashboardViewController:UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + self.usertChart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BarChartTableViewCell.identifier, for: indexPath) as! BarChartTableViewCell
            cell.contentView.isUserInteractionEnabled = false
            cell.setData(data: self.usertChart)
            //cell.setDataCount(4, range: 4)
            return cell
        } else  if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BarChartTableViewCell.identifier, for: indexPath) as! BarChartTableViewCell
            cell.setDataForShop(data: self.shopChart)
            cell.contentView.isUserInteractionEnabled = false
//            cell.setDataCount(5, range: 2)
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductGroupCell.identifier, for: indexPath) as! ProductGroupCell
            cell.set()
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductGroupCell.identifier, for: indexPath) as! ProductGroupCell
            cell.setData(data: self.usertChart[indexPath.row - 3])
            return cell
        }
    }
            
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1:
            return 500
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

class ProductGroupCell:UITableViewCell {
    
    var nameLabel = UILabel()
    var productGroup = UILabel()
    var product = UILabel()
    var sellingLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = AppAppearance.eleven
        nameLabel.textAlignment = .center
        
        
        productGroup = UILabel()
        productGroup.translatesAutoresizingMaskIntoConstraints = false
        productGroup.font = AppAppearance.eleven
        productGroup.textAlignment = .center


        product = UILabel()
        product.translatesAutoresizingMaskIntoConstraints = false
        product.font = AppAppearance.eleven
        product.textAlignment = .center


        sellingLabel = UILabel()
        sellingLabel.translatesAutoresizingMaskIntoConstraints = false
        sellingLabel.font = AppAppearance.eleven
        sellingLabel.textAlignment = .center
        
        self.addSubviews([nameLabel, productGroup, product, sellingLabel])
        
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.25).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        
        productGroup.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        productGroup.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.25).isActive = true
        productGroup.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        
        product.leadingAnchor.constraint(equalTo: productGroup.trailingAnchor).isActive = true
        product.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.25).isActive = true
        product.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        
        sellingLabel.leadingAnchor.constraint(equalTo: product.trailingAnchor).isActive = true
        sellingLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.25).isActive = true
        sellingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    }
    
    func setData(data: DashboardChart) {
        self.nameLabel.text = data.employee
        self.product.text = "\(data.expectation)"
        self.productGroup.text = data.product_group
        self.sellingLabel.text = "\(data.sales)"
    }
    
    func set() {
        self.nameLabel.text = "Kişi"
        self.product.text = "Beklenen"
        self.productGroup.text = "Ürün Grubu"
        self.sellingLabel.text = "Satış"
    }
}

extension ProductGroupCell {
    static let identifier = "ProductGroupCell"
}
