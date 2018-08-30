//
//  TabBarController.swift
//  Platinum Points
//
//  Created by Brian Johncox on 7/21/18.
//  Copyright © 2018 DecodeProgramming. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let permission = User.get(.permissionLevel) else{
            return
        }
        let p = permission as! Int
        if( p > 0){
            let rhpView = self.storyboard?.instantiateViewController(withIdentifier: "RHP_Only_Approval") as! UINavigationController
            rhpView.tabBarItem = UITabBarItem(title: "Approve", image: #imageLiteral(resourceName: "check"), selectedImage: #imageLiteral(resourceName: "check"))
            let qrView = self.storyboard?.instantiateViewController(withIdentifier: "QR_Code") as! UINavigationController
            qrView.tabBarItem = UITabBarItem(title: "QR", image: #imageLiteral(resourceName: "QRCode"), selectedImage: #imageLiteral(resourceName: "QRCode"))
            if let vcs = self.viewControllers {
                var newVcs : [UIViewController] = []
                for vc in vcs {
                   newVcs.append(vc)
                }
                newVcs.append(rhpView)
                newVcs.append(qrView)
                self.setViewControllers(newVcs, animated: false)
            }
        }
        // Do any additional setup after loading the view.
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(NewLaunch.newLaunch.isFirstLaunch){
            createNewLaunchAlert()
        }
    }
    
    //This will be for showing announcements
    func createNewLaunchAlert(){
        let alert = UIAlertController(title: "Are you interested in joining Development Committee?", message: "Development Committee is looking for software developers, marketers, and designers to help with the future of Purdue HCR. If you are interested in helping, checkout our Discord channel!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Take me to the Discord", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            UIApplication.shared.open(URL(string: "https://discord.gg/jptXrYG")!, options: [:], completionHandler: nil)
            }))
        alert.addAction(UIAlertAction(title: "No thanks", style: UIAlertActionStyle.default, handler: {(action)in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
