//
//  ContainerController.swift
//  CryptoCove
//
//  Created by Jonathan Dominic Pasquin on 7/15/20.
//

//import Foundation
//import UIKit
//import Firebase
//import SwiftUI
//
//class ContainerController: UIViewController {
//    
////    var menuController: MenuController!
//    var centerController: UIViewController!
//    var isExpanded = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureUserCryptoController()
//    }
//
//    @objc func handleSignOut() {
//        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
//        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
//            self.signOut()
//        }))
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        present(alertController, animated: true, completion: nil)
//    }
//
//    func configureUserCryptoController() {
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//        let homeController = UserCryptoController()
//        centerController = UINavigationController(rootViewController: homeController)
//        view.addSubview(centerController.view)
//        addChild(centerController)
//        centerController.didMove(toParent: self)
//    }
//
//    func configureHomeController() {
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//        let homeController = HomeController()
//        centerController = UINavigationController(rootViewController: homeController)
//        homeController.delegate = self
//        view.addSubview(centerController.view)
//        addChild(centerController)
//        centerController.didMove(toParent: self)
//    }
//
//    func configureMenuController() {
//        if menuController == nil {
//            menuController = MenuController()
//            menuController.delegate = self
//            view.insertSubview(menuController.view, at: 0)
//            addChild(menuController)
//            menuController.didMove(toParent: self)
//        }
//
//    }
//
//    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
//
//        if shouldExpand {
//
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 140
//            }, completion: nil )
//
//        } else {
//
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//
//            }, completion: nil )
//
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                self.centerController.view.frame.origin.x = 0
//
//            }) { (_) in
//                guard let menuOption = menuOption else { return }
//                self.didSelectMenuOption(menuOption: menuOption)
//
//            }
//        }
//    }
//
//
//    func signOut() {
//        do {
//            try Auth.auth().signOut()
//
//            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//            navigationController?.navigationBar.isHidden = true
//            self.navigationController?.popToRootViewController(animated: true)
//
//        } catch let error {
//            print("Failed to sign out with error..", error)
//        }
//    }
//
//
//    func didSelectMenuOption(menuOption: MenuOption) {
//        switch menuOption {
//
//        case .Profile:
//            self.navigationController?.popToProfileController()
//            HomeController().handleSelfDismiss()
//        case .Settings:
//            print("Show Settings")
//        case .Help:
//            print("Show Help")
//        case .SignOut:
//            self.handleSignOut()
//        }
//    }
//}
//
//extension ContainerController: HomeControllerDelegate {
//    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
//        if !isExpanded {
//            configureMenuController()
//
//        }
//
//        isExpanded = !isExpanded
//        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
//    }
//
//}
//
//public extension UINavigationController {
//
//    /**
//        This makes the font super cool.
//     */
//    func popToProfileController(transitionType type: String = CATransitionType.push.rawValue, duration: CFTimeInterval = 0.3) {
//        self.addTransition(transitionType: type, duration: duration)
//        let transition = CATransition()
//        transition.duration = 0.3
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromRight
//        self.view.layer.add(transition, forKey: kCATransition)
//        self.pushViewController(ProfileController(), animated: false)
//      }
//
//    func fadeToProfileController(transitionType type: String = CATransitionType.push.rawValue, duration: CFTimeInterval = 0.3) {
//        self.addTransition(transitionType: type, duration: duration)
//        self.pushViewController(ProfileController(), animated: false)
//    }
//
//
//    private func addTransition(transitionType type: String = CATransitionSubtype.fromTop.rawValue, duration: CFTimeInterval = 0.3) {
//        let transition = CATransition()
//        transition.duration = duration
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.type = CATransitionType(rawValue: type)
//        self.view.layer.add(transition, forKey: nil)
//    }
//
//
//
//}


