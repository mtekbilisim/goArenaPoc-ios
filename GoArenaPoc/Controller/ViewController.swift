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
import Alamofire

class ViewController: UIViewController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    var networkManager = NetworkManager()
    let hud = JGProgressHUD(style: .extraLight)
    var connectedTheInternet:Bool = false
    var connectionErrorShown :Bool = false
    var isPostDone:Bool = false
    
    init(networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
     }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
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
            self.hud.textLabel.font = AppAppearance.fifteenB
            self.hud.textLabel.text = "Lütfen Bekleyiniz"
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
    
    func showSuccessMessage(message:String){
       if isPostDone {
            return
        } else {
            DispatchQueue.main.async {
                self.isPostDone = true
                let leftView = UIImageView(image: UIImage(named: "logo2"))
                let banner = FloatingNotificationBanner(title: "", subtitle: message,
                                                   leftView: leftView,
                                                   style: .success)
                banner.titleLabel?.font = AppAppearance.sixteenB
                banner.subtitleLabel?.font = AppAppearance.fifteenB
                banner.delegate = self
                banner.show(queuePosition: .front,bannerPosition: .top,cornerRadius: 4,shadowBlurRadius: 2)
                return
            }
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
    
    func uploadImage( endUrl: String, imageData: Data?, parameters: [String : Any]?, onCompletion: ((_ file:File) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
       
        let token = User.storedToken()
        let headers = [
                "Authorization": token,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        AF.upload(multipartFormData: { multipartFormData in
            
            if let parameters = parameters {
                for (key, value) in parameters {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? Int {
                        multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? NSArray {
                        temp.forEach({ element in
                            let keyObj = key + "[]"
                            if let string = element as? String {
                                multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                            } else
                                if let num = element as? Int {
                                    let value = "\(num)"
                                    multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                            }
                        })
                    }
                }
            }
            
            if let data = imageData {
                multipartFormData.append(data, withName: "file", fileName: "\(Date.init().timeIntervalSince1970).png", mimeType: "image/png")
            }
        },
                  to: endUrl, method: .post , headers: [
                    "Authorization": token,
                    "Content-Type": "application/x-www-form-urlencoded"
                ])
            .responseJSON(completionHandler: { (response) in
                
                print(response)
                
                if let err = response.error{
                    print(err)
                    onError?(err)
                    return
                }
                print("Succesfully uploaded")
                
                let json = response.data
                let jsonDecoder = JSONDecoder()
                do {
                    let fileResponse = try jsonDecoder.decode(FileResponse.self, from: json!)
                    onCompletion!(fileResponse.data)
                } catch let error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.hideLoading()
                    }
                }
//                let fileResponse = response.data as! File
//                let file = File(fileName: fileResponse.fileName, fileDownloadUri: "", fileType: "", size: 0)
//                print(response)
//                if (json != nil)
//                {
//                    //let jsonObject = JSON(json!)
//                    print(json)
//                }
            })
    }
    
    func uploadVideo( endUrl: String, imageData: Data?, parameters: [String : Any]?, onCompletion: ((_ file:File) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
       
        AF.upload(multipartFormData: { multipartFormData in
            
            if let parameters = parameters {
                for (key, value) in parameters {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? Int {
                        multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? NSArray {
                        temp.forEach({ element in
                            let keyObj = key + "[]"
                            if let string = element as? String {
                                multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                            } else
                                if let num = element as? Int {
                                    let value = "\(num)"
                                    multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                            }
                        })
                    }
                }
            }
            
            if let data = imageData {
                let timestamp = NSDate().timeIntervalSince1970 // just for some random name.
                multipartFormData.append(data, withName: "file", fileName: "\(timestamp).mp4", mimeType: "\(timestamp)/mp4")
            }
        },
                  to: endUrl, method: .post , headers: nil)
            .responseJSON(completionHandler: { (response) in
                
                print(response)
                
                if let err = response.error{
                    print(err)
                    onError?(err)
                    return
                }
                print("Succesfully uploaded")
                
                let json = response.data
                let jsonDecoder = JSONDecoder()
                do {
                    let fileResponse = try jsonDecoder.decode(FileResponse.self, from: json!)
                    onCompletion!(fileResponse.data)
                } catch let error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.hideLoading()
                    }
                }
//                let fileResponse = response.data as! File
//                let file = File(fileName: fileResponse.fileName, fileDownloadUri: "", fileType: "", size: 0)
//                print(response)
//                if (json != nil)
//                {
//                    //let jsonObject = JSON(json!)
//                    print(json)
//                }
            })
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
 
    func showAlert(string: String) {
        let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
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

