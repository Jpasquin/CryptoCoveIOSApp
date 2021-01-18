//
//  ProfileController.swift
//  CryptoCove
//
//  Created by Jonathan Dominic Pasquin on 7/15/20.
//

import Foundation
import UIKit
import Firebase

class ProfileController: UIViewController {
        
        
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        return label
    }()
    
    var invalidLoginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .googleRed()
        label.text = "Invalid"
        label.alpha = 0
        return label
    }()
    
    lazy var firstnameContainerView: UIView = {
        let view = UIView()
        return view.textSansImageContainerView(view: view, firstnameTextField)
    }()
    
    
    lazy var lastnameContainerView: UIView = {
        let view = UIView()
        return view.textSansImageContainerView(view: view, lastnameTextField)
    }()
    
    lazy var currencyContainerView: UIView = {
        let view = UIView()
        return view.textSansImageContainerView(view: view, currencyTextField)
    }()
    
    lazy var firstnameTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.alpha = 0
        return tf
    }()
    
    lazy var lastnameTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.alpha = 0
        return tf
    }()
    
    lazy var currencyTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.alpha = 0
        return tf
    }()
        
    @objc func handleBackButton() {
        handleReturnToHomeRequest()
        
    }
    
    @objc func handleSignOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func handleEditProfileRequest() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want these changes?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            self.createFirstLastName()
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
            
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        loadProfile()
        
    }
    
    func loadProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("Users").child(uid).child("email").observeSingleEvent(of: .value) { (snapshot) in
        guard let email = snapshot.value as? String else { return }
        Database.database().reference().child("Users").child(uid).child("firstname").observeSingleEvent(of: .value) { (snapshot) in
        guard let firstname = snapshot.value as? String else { return }
        Database.database().reference().child("Users").child(uid).child("lastname").observeSingleEvent(of: .value) { (snapshot) in
        guard let lastname = snapshot.value as? String else { return }
            Database.database().reference().child("Users").child(uid).child("IOS").child("currencyType").observeSingleEvent(of: .value) { (snapshot) in
            guard let currency = snapshot.value as? String else { return }
            
                self.emailLabel.text = "\(email)"
                self.firstnameTextField.text = "\(firstname)"
                self.lastnameTextField.text = "\(lastname)"
                self.currencyTextField.text = "\(currency)"
                
                UIView.animate(withDuration: 0.25, animations: {
                
                self.emailLabel.alpha = 1
                self.firstnameTextField.alpha = 1
                self.lastnameTextField.alpha = 1
                self.currencyTextField.alpha = 1
                    
                        })
                    }
                }
            }
        }
    }
    func handleReturnToHomeRequest() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("Users").child(uid).child("firstname").observeSingleEvent(of: .value) { (snapshot) in
        guard let firstname = snapshot.value as? String else { return }
            Database.database().reference().child("Users").child(uid).child("lastname").observeSingleEvent(of: .value) { (snapshot) in
        guard let lastname = snapshot.value as? String else { return }
            
        
            if self.firstnameTextField.text == firstname, self.lastnameTextField.text == lastname {
                self.returnToHome()
                
            } else {
                
                self.handleEditProfileRequest()
                
                
                }
            }
        }
    }
    
    func createFirstLastName() {
            // for First Name use: \(firstname)
            // for Last Name use: \(lastname)
        guard let uid = Auth.auth().currentUser?.uid else { return }
            let namevalue = ["firstname": self.firstnameTextField.text, "lastname": self.lastnameTextField.text]
        let ref = Database.database().reference().child("Users").child(uid).updateChildValues(namevalue)
            returnToHome()
            
    }
    
    func toggleCurrencyChange() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let currencyvalue = ["currencyType": self.currencyTextField.text]
        let ref = Database.database().reference().child("Users").child(uid).child("IOS").updateChildValues(currencyvalue)
        
    }
    
    func returnToHome() {
        
        toggleCurrencyChange()
        
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.popToContainerController()
        
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            navigationController?.navigationBar.isHidden = true
            self.tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(LoginController(), animated: true)
     
        } catch let error {
            print("Failed to sign out with error..", error)
        }
    }
    
    func configureViewComponents() {
        
        navigationItem.title = "Profile"
        view.backgroundColor = UIColor.mainBlack()
        
        navigationController?.navigationBar.isHidden = false
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackArrowIcon"), style: .plain, target: self, action: #selector(handleBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.mainGrey()
        
        //Temporary Sign Out
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackArrowIcon"), style: .plain, target: self, action: #selector(handleSignOut))
        navigationItem.rightBarButtonItem?.tintColor = .white

        
        
        
        view.addSubview(emailLabel)
        emailLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 96, paddingLeft: 40, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(firstnameContainerView)
        firstnameContainerView.anchor(top: emailLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(lastnameContainerView)
        lastnameContainerView.anchor(top: firstnameContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(currencyContainerView)
        currencyContainerView.anchor(top: lastnameContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        
        
    }
}

public extension UINavigationController {

    /**
        This makes the font super cool.
     */
    func popToContainerController(transitionType type: String = CATransitionType.push.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.layer.add(transition, forKey: kCATransition)
        self.pushViewController(TabBarController(), animated: false)
      }

    private func addTransition(transitionType type: String = CATransitionSubtype.fromRight.rawValue, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType(rawValue: type)
        self.view.layer.add(transition, forKey: nil)
    }

}
