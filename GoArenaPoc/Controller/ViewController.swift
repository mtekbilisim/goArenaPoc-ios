//
//  ViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 27.01.2021.
//

import UIKit
import NotificationBannerSwift
import JGProgressHUD
import FontAwesome_swift

class ViewController: UIViewController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    let hud = JGProgressHUD(style: .extraLight)
    var connectedTheInternet:Bool = false
    var connectionErrorShown :Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          if #available(iOS 13.0, *) {
             return .lightContent
          } else {
              return .default
          }
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SPNativeColors.customGray
        showNavigation()
        self.navigationController?.interactivePopGestureRecognizer!.delegate = nil
        addShadowToBar()


    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tabBarController?.tabBar.layer.masksToBounds = true
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.barStyle = .default
        self.tabBarController?.tabBar.layer.cornerRadius = 25
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

    }
    
    @objc private func reachabilityChanged( notification: NSNotification ) {
        guard let reachability = notification.object as? Reachability else { return }
        
        print(reachability.connection)

        if reachability.connection == .unavailable {
            connectedTheInternet = false
            if connectionErrorShown == false {
                //DispatchQueue.main.async {
                    let banner = GrowingNotificationBanner(title: "Bağlantı hatası", subtitle: "Lütfen internete bağlantınızı kontrol ediniz.", style: .danger)
                    banner.show(bannerPosition: .top)
                    self.connectionErrorShown = true
                    //return
                //}
            } else {
                return
            }
        } else if reachability.connection == .cellular || reachability.connection == .wifi {
            connectedTheInternet = true
        } else {
            print("reachability.connection unknown")
        }
    }

    
    //MARK: - ADD/REMOVE TABBAR

    func showTabbar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func hideTabbar() {
        self.tabBarController?.tabBar.isHidden = true
    }

    //MARK: - BACK TAPPED
    
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    func addBackButton(){
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        let origImage = UIImage(named: "arrowRight")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(tintedImage, for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(self.backButtonTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    //MARK: - SHOW/HIDE NAVIGATION CONTROLLER
    func showNavigation(){
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func hideNavigation(){
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func getTabbarHeight() -> CGFloat {
        let tabBarHeight = tabBarController?.tabBar.frame.size.height
        return tabBarHeight ?? 50
    }
    
    func topViewController()-> UIViewController{
        var topViewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!

        while ((topViewController.presentedViewController) != nil) {
            topViewController = topViewController.presentedViewController!;
        }

        return topViewController
    }

    func showShareActivity(msg:String?, image:UIImage?, url:String?, sourceRect:CGRect?){
        var objectsToShare = [AnyObject]()

        if let url = url {
            objectsToShare = [url as AnyObject]
        }

        if let image = image {
            objectsToShare = [image as AnyObject]
        }

        if let msg = msg {
            objectsToShare = [msg as AnyObject]
        }

        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        activityVC.popoverPresentationController?.sourceView = topViewController().view
        if let sourceRect = sourceRect {
            activityVC.popoverPresentationController?.sourceRect = sourceRect
        }

        topViewController().present(activityVC, animated: true, completion: nil)
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.hud.textLabel.text = "Yükleniyor"
            self.hud.show(in: self.view)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.hud.dismiss(afterDelay: 0.5)
        }
    }
    
    func addShadowToBar() {

        self.navigationController?.navigationBar.layer.shadowColor = UIColor(red: 246.0 / 255.0, green: 249.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0).cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1
        self.navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    func showServerError(){
        DispatchQueue.main.async {
      
            let icon = UIImage.fontAwesomeIcon(name: .server, style: .solid, textColor: .white, size: CGSize(width: 30, height: 30))

            let leftView = UIImageView(image: icon)

            let banner = FloatingNotificationBanner(title: "İnternet Baglantısı", subtitle: "İnternete bağlı değilsiniz.",
                                               leftView: leftView,
                                               style: .danger)
            
            banner.titleLabel?.font = AppAppearance.sixteenB
            banner.subtitleLabel?.font = AppAppearance.fourteen
            banner.delegate = self

            banner.show(queuePosition: .front,bannerPosition: .top,cornerRadius: 10,shadowBlurRadius: 15)
        }
    }
    
    
    
    func dialNumber(number : String) {
        let formatedNumber = number.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
        print(formatedNumber)

        guard let url = URL(string: "telprompt://\(formatedNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension UIViewController {

/**
 *  Height of status bar + navigation bar (if navigation bar exist)
 */

    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    var statusBarHeight:CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
}


extension UIViewController {
 
    func showError(string: String) {
        let alert = UIAlertController(title: "Bağlantı hatası", message: string, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default)
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
}


extension ViewController: NotificationBannerDelegate {
    
    internal func notificationBannerWillAppear(_ banner: BaseNotificationBanner) {
        print("[NotificationBannerDelegate] Banner will appear")
    }
    
    internal func notificationBannerDidAppear(_ banner: BaseNotificationBanner) {
        print("[NotificationBannerDelegate] Banner did appear")
    }
    
    internal func notificationBannerWillDisappear(_ banner: BaseNotificationBanner) {
        print("[NotificationBannerDelegate] Banner will disappear")
    }
    
    internal func notificationBannerDidDisappear(_ banner: BaseNotificationBanner) {
        print("[NotificationBannerDelegate] Banner did disappear")
    }
}

