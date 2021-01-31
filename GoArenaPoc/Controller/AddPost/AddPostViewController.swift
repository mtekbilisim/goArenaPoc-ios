//
//  AddPostViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 29.01.2021.
//

import UIKit

class AddPostViewController: ViewController {

    var sendPostButton = SPButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        hideLoading()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Post"
        setupView()
    }
    
    // MARK: - Send Post Tapped

    @objc func sendPost(_ sender: UIButton) {
        
    }
    
    // MARK: - Close VC
    @objc
    func dismissView() {
        dismiss()
    }
}

// MARK: - AddPostViewController Extensions

extension AddPostViewController {
    private func setupView() {
        view.backgroundColor = SPNativeColors.white
        addNavigationButtons()
    }
    
    private func addNavigationButtons() {
        //CANCEL BUTTON
        let btn1 = SPButton()
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.titleLabel?.font = AppAppearance.fifteenL
        btn1.setTitle("İptal", color: UIColor.init(hex: "059FE7"))
        btn1.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        let item1 = UIBarButtonItem()
        item1.customView = btn1

        //SEND BUTTON
        sendPostButton = SPButton()
        sendPostButton.set(enable: false, animatable: true)
        sendPostButton.setTitle("Gönder")
        sendPostButton.titleLabel?.font = AppAppearance.fifteenB
        sendPostButton.titleLabel?.textColor = UIColor.init(hex: "059FE7")
        sendPostButton.addShadow(offset: CGSize(width: 0, height: 0), color: .yellow, radius: 1, opacity: 0.1, cornerRadius: 6)
        sendPostButton.backgroundColor = Global.appColor
        sendPostButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        sendPostButton.addTarget(self, action: #selector(sendPost), for: .touchUpInside)
        let item2 = UIBarButtonItem()
        item2.customView = sendPostButton

        self.navigationItem.leftBarButtonItems = [item1]
        self.navigationItem.rightBarButtonItems = [item2]
    }
}
