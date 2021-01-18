//
//  TabBarController.swift
//  CryptoCove
//
//  Created by Jonathan Dominic Pasquin on 8/2/20.
//

import Foundation
import UIKit
import SwiftUI
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var freshLaunch = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        tabBar.selectedImageTintColor = UIColor.mainGreyLight()
        tabBar.barTintColor = UIColor.mainGrey()
        
        configureTabBar()

        if freshLaunch == true {
            freshLaunch = false
            self.selectedIndex = 3 // 4th tab
        }

    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
      if viewController.isKind(of: AddCoinController.self) {
         let vc =  AddCoinController()
         vc.modalPresentationStyle = .popover
         self.present(vc, animated: true, completion: nil)
         return false
      }
      return true
    }
    
    
    func configureTabBar() {
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.hidesBackButton = true
        
        let walletcontroller = UINavigationController(rootViewController: WalletController())
        walletcontroller.tabBarItem.image = UIImage(named: "WalletIcon-1")?.withRenderingMode(.alwaysOriginal)
        walletcontroller.tabBarItem.selectedImage = UIImage(named: "WalletIcon-1")
        walletcontroller.tabBarItem.title = "Wallets"
        
        let marketsimcontroller = UINavigationController(rootViewController: MSController())
        marketsimcontroller.tabBarItem.image = UIImage(named: "MSIcon-1")?.withRenderingMode(.alwaysOriginal)
        marketsimcontroller.tabBarItem.selectedImage = UIImage(named: "MSIcon-1")
        marketsimcontroller.tabBarItem.title = "A-M"
        
        let addcryptocontroller = AddCoinController()
        addcryptocontroller.tabBarItem.isEnabled = false
        addcryptocontroller.tabBarItem.image = UIImage(named: "AddIconTest")?.withRenderingMode(.alwaysOriginal)
        addcryptocontroller.tabBarItem.selectedImage = UIImage(named: "AddIconTest")
        
        let usercryptocontroller = UINavigationController(rootViewController: UserCryptoController())
        usercryptocontroller.tabBarItem.image = UIImage(named: "HomeIcon-2")?.withRenderingMode(.alwaysOriginal)
        usercryptocontroller.tabBarItem.selectedImage = UIImage(named: "HomeIcon-2")
        usercryptocontroller.tabBarItem.title = "Home"
        
        let settingscontroller = UINavigationController(rootViewController: ProfileController())
        settingscontroller.tabBarItem.image = UIImage(named: "SettingsIcon")?.withRenderingMode(.alwaysOriginal)
        settingscontroller.tabBarItem.selectedImage = UIImage(named: "SettingsIcon")
        settingscontroller.tabBarItem.title = "Settings"
        
        viewControllers = [walletcontroller, marketsimcontroller, addcryptocontroller, usercryptocontroller, settingscontroller]
        
        
    }
}
