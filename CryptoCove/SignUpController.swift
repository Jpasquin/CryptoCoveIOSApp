//
//  SignUpController.swift
//  CryptoCove
//
//  Created by Jonathan Dominic Pasquin on 7/15/20.
//

import Foundation
import UIKit
import Firebase

class SignUpController: UIViewController {
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "LogoTest")
        return iv
    }()
    
    var invalidLoginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .googleRed()
        label.text = "Invalid"
        label.alpha = 0
        return label
    }()
    
    var currencyTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .googleRed()
        label.text = "CAD"
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
    
    lazy var emailContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, #imageLiteral(resourceName: "MailIcon"), emailTextField)
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, #imageLiteral(resourceName: "LockIcon"), passwordTextField)
    }()
    
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Email", isSecureTextEntry: false)
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Password", isSecureTextEntry: true)
    }()
    
    lazy var firstnameTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "First Name", isSecureTextEntry: false)
    }()
    
    lazy var lastnameTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Last Name", isSecureTextEntry: false)
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN UP", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.mainBlue(), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleEmptyTextFields), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let AlreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        
        
    }
    @objc func handleEmptyTextFields() {
        if firstnameTextField.text == "" || lastnameTextField.text == "" {
            //Handles Empty Firstname or Lastname
            invalidLoginLabel.alpha = 1
            print("Error... Empty Firstname or Lastname")
            
        } else {
            
            handleSignUp()
            
        }
        
    }
    
    @objc func handleSignUp() {
        //Values
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let firstname = firstnameTextField.text else { return }
        guard let lastname = lastnameTextField.text else { return }
        //IOS Values
        guard let currencyType = currencyTypeLabel.text else { return }
        let cryptoTab0 = "0"
        let cryptoTab1 = "0"
        let cryptoTab2 = "0"
        let cryptoTab3 = "0"
        let cryptoTab4 = "0"
        
        createUser(withEmail: email, password: password, firstname: firstname, lastname: lastname, currencyType: currencyType, cryptoTab0: cryptoTab0, cryptoTab1: cryptoTab1, cryptoTab2: cryptoTab2, cryptoTab3: cryptoTab3, cryptoTab4: cryptoTab4)
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func createUser(withEmail email: String, password: String, firstname: String, lastname: String, currencyType: String, cryptoTab0: String,cryptoTab1: String, cryptoTab2: String, cryptoTab3: String, cryptoTab4: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                print("Failed to sign user up with error: ", error.localizedDescription)
                
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = ["email": email, "password": password, "firstname": firstname, "lastname": lastname]
            let IOSvalues = ["currencyType": currencyType, "0": cryptoTab0,"1": cryptoTab1, "2": cryptoTab2, "3": cryptoTab3, "4": cryptoTab4]

            Database.database().reference().child("Users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if let error = error {
                    print("Failed to update database values with error: ", error.localizedDescription)
                    
                    return
                }
                Database.database().reference().child("Users").child(uid).child("IOS").updateChildValues(IOSvalues, withCompletionBlock: { (error, ref) in
                    if let error = error {
                        print("Failed to update database values with error: ", error.localizedDescription)
                        
                        return
                    }
                self.navigationController?.pushViewController(TabBarController(), animated: true)
                self.dismiss(animated: true, completion: nil)
                
            })
        })
    }
}
    
    func configureViewComponents() {
        
        view.backgroundColor = UIColor.mainGreyLight()
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 80, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(firstnameContainerView)
        firstnameContainerView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.centerXAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        
        view.addSubview(lastnameContainerView)
        lastnameContainerView.anchor(top: logoImageView.bottomAnchor, left: view.centerXAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: firstnameContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(passwordContainerView)
        passwordContainerView.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(loginButton)
        loginButton.anchor(top: passwordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(AlreadyHaveAccountButton)
        AlreadyHaveAccountButton.anchor(top: loginButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
    }
    
}
