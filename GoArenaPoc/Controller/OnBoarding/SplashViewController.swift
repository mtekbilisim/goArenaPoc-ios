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
    
    var networkManager: NetworkManager!
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
        i.frame = CGRect(x: (self.view.frame.width / 2) - 90, y: (self.view.frame.height / 2) - 90, width: 180, height: 180)
        i.image = UIImage(named: "logo")
        i.contentMode = .scaleAspectFit
        i.setCorner(radius: 90)
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
    
    init(networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
    }
        
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
//
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
        view.backgroundColor =  UIColor.init(hex: "3EBEF5")

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
            connectAPI()
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
                        self.goToDashboard()
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

      UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1.5, options: UIView.AnimationOptions.curveLinear, animations: {
          for constraint in button.constraints{
              if (constraint.firstAttribute == .height)||(constraint.firstAttribute == .width){
                  constraint.constant = 300
              }
          }
          self.view.layoutIfNeeded()
      }, completion: { (true) in
      })
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
          UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1.5, options: UIView.AnimationOptions.curveLinear, animations: {

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
