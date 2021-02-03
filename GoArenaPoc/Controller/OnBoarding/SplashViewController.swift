//
//  SplashViewController.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 27.01.2021.
//

import UIKit
import NotificationBannerSwift

import UIKit
import NotificationBannerSwift

class SplashViewController: ViewController, UIViewControllerTransitioningDelegate {
    
    var triggerButton:UIButton!
    var isOnline:Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          if #available(iOS 13.0, *) {
             return .lightContent
          } else {
              return .default
          }
      }

    lazy var appLogo: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
    
        i.image = UIImage(named: "logo2")
        i.contentMode = .scaleAspectFit
//        i.setCorner(radius: 90)
        return i
    }()
    
    lazy var version: SPLabel = {
        let l = SPLabel()
        l.frame = CGRect(x: 10, y: view.frame.height - 60, width: view.frame.width - 20, height: 30)
        l.textAlignment = .center
        l.font = Global.defaultFont
        l.textColor = .white
        l.text = "Versiyon \(Bundle.main.infoDictionary!["CFBundleShortVersionString"]! as! String)"
        return l
    }()
   
    let transition = VLCircularTransition()
    let animationCoordinator = TransitionCoordinator()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        
      if let reachability = AppDelegate.sharedAppDelegate()?.reachability {
               NotificationCenter.default.addObserver( self,
                                                       selector: #selector( self.connectionChanged ),
                                                       name: Notification.Name.reachabilityChanged,
                                                       object: reachability )
           }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.delegate = self.animationCoordinator
        setupUI()
    }
    
    
    private func setupUI() {
        view.backgroundColor =  UIColor.init(hex: "059FE7")

        triggerButton = UIButton()
        triggerButton.backgroundColor = SPNativeColors.white
        triggerButton.layer.cornerRadius = 40
        triggerButton.layer.masksToBounds = true
        triggerButton.alpha = 0
        triggerButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(triggerButton)
        triggerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        triggerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addSubview(version)
        view.addSubview(appLogo)
        
        appLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

 

    }
    
    @objc private func connectionChanged( notification: NSNotification ) {
        guard let reachability = notification.object as? Reachability else { return }
        
        if reachability.connection == .unavailable {
            isOnline = false
            DispatchQueue.main.async {
                let banner = GrowingNotificationBanner(title: "Bağlantı hatası",
                                                       subtitle: "Lütfen internete bağlantınızı kontrol ediniz.",
                                                       style: .danger)
                banner.show(bannerPosition: .top)
                //self.connectionErrorShown = true
                return
            }
                
        } else if reachability.connection == .cellular || reachability.connection == .wifi {
            isOnline = true
            //connectAPI()
            checkToken()
        }
    }
    
    func connectAPI () {
        let delayDuration: Double = 2.0
        let delayable: Bool = true
        if delayable{
            delay(Double(delayDuration)){
                self.scaleLogo()
                
            }
        }
    }
    
    func checkToken() {
        print("3")
        if User.loggedIn() {
            self.tokenRequest()
        } else {
            DispatchQueue.main.async {
                self.showLogin()
            }
        }
    }
    
    private func tokenRequest () {
        networkManager.sendRequest(route: .me, User.self) { [weak self] (result, error) in
            guard let self = self else { return }
            if let _ = error {
                DispatchQueue.main.async {
                    self.showLogin()
                }
            }
            if let result = result {
                if let user = result.data   {
                    User.saveUser(user: user)
                    self.scaleLogo()
                }
            }
        }
    }
    
    private func showLogin() {
        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.goToLogin()
        }
    }
    
    private func scaleLogo() {

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.appLogo.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2) // Scale your image
            }) { (finished) in
                UIView.animate(withDuration: 0.2, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.appLogo.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1) // Scale your image
                }) { (finished) in
                    self.appLogo.transform = CGAffineTransform.identity.scaledBy(x: 0, y: 0) // Scale your image
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                        delay(0.3) {
                            self.goToDashboard()
                        }
                    }
                }
            }
        }
    }
    
    func goToDashboard(){
        let vc = ArenaTabbarController()
        self.navigationController?.pushViewController(viewController: vc, animated: true, completion: {
            if let app = UIApplication.shared.delegate as? AppDelegate {
                app.openApp()
            }
        })
    }

}

extension SplashViewController: CircleTransitionable {
    var mainView: UIView {
        return self.view
    }
}
extension SplashViewController {
  func animateSender(button:UIImageView){

      UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1.5, options: UIView.AnimationOptions.curveLinear, animations: {
          for constraint in button.constraints{
              if (constraint.firstAttribute == .height)||(constraint.firstAttribute == .width){
                  constraint.constant = 300
              }
          }
          self.view.layoutIfNeeded()
      }, completion: { (true) in
      })
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
          UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1.5, options: UIView.AnimationOptions.curveLinear, animations: {

              for constraint in button.constraints{
                  if (constraint.firstAttribute == .height)||(constraint.firstAttribute == .width){
                      constraint.constant = 0.5
                  }
              }
              self.view.layoutIfNeeded()
              button.frame.size.width = button.frame.size.height
              button.layer.cornerRadius = button.frame.size.width/2.0
              button.layer.masksToBounds = true
              button.clipsToBounds = true
              button.center = self.view.center
          }, completion: { (true) in
              UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 2.5, options: UIView.AnimationOptions.curveLinear, animations: {
                  let pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
                  pulseAnimation.duration = 0.8
                  pulseAnimation.fromValue = NSNumber(value: 1.0)
                  pulseAnimation.toValue = NSNumber(value: 1.2)
                  pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                  pulseAnimation.autoreverses = true
                  pulseAnimation.repeatCount = .greatestFiniteMagnitude
                  button.layer.add(pulseAnimation, forKey: nil)
              }, completion: { (true) in
              })
          })
      }
  }
}
