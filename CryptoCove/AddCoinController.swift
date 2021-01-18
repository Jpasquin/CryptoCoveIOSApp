//
//  AddCoinController.swift
//  CryptoCove
//
//  Created by Jonathan Dominic Pasquin on 8/2/20.
//

import Foundation
import UIKit
import Firebase

class AddCoinController: UIViewController {
    
    lazy var UnVerifiedCoinContainerView: UIView = {
        let view = UIView()
        return view.textSansImageContainerView(view: view, UnVerifiedCoinTextField)
    }()
    
    lazy var UnVerifiedCoinTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.alpha = 1
        return tf.textField(withPlaceolder: "Symbol", isSecureTextEntry: false)
    }()
    
    let AddUnVerifiedCoinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD COIN", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.mainBlue(), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleAddUnverifiedCoin), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        
    }
    
    @objc func handleAddUnverifiedCoin() {
        AddUnverifiedCoin()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func showUserCryptoController() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    let Dismiss: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Dismiss", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.googleRed()])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(showUserCryptoController), for: .touchUpInside)
        return button
    }()
    
    func AddUnverifiedCoin() {
        CryptoTabRef0.observeSingleEvent(of: .value) { (snapshot) in
            guard let cryptoTab0 = snapshot.value as? String else { return }
        CryptoTabRef1.observeSingleEvent(of: .value) { (snapshot) in
            guard let cryptoTab1 = snapshot.value as? String else { return }
        CryptoTabRef2.observeSingleEvent(of: .value) { (snapshot) in
            guard let cryptoTab2 = snapshot.value as? String else { return }
        CryptoTabRef3.observeSingleEvent(of: .value) { (snapshot) in
            guard let cryptoTab3 = snapshot.value as? String else { return }
        CryptoTabRef4.observeSingleEvent(of: .value) { (snapshot) in
            guard let cryptoTab4 = snapshot.value as? String else { return }
     
                        if cryptoTab0 == "0" {
                            let cryptotype = self.UnVerifiedCoinTextField.text
                            let cryptotab = ["0": cryptotype]
                            let ref = CryptoTabRef.updateChildValues(cryptotab)
                            
                        } else {
                            
                            if cryptoTab1 == "0" {
                                
                                let cryptotype = self.UnVerifiedCoinTextField.text
                                let cryptotab = ["1": cryptotype]
                                let ref = CryptoTabRef.updateChildValues(cryptotab)
                                
                            } else {
                                
                                if cryptoTab2 == "0" {
                                    
                                    let cryptotype = self.UnVerifiedCoinTextField.text
                                    let cryptotab = ["2": cryptotype]
                                    let ref = CryptoTabRef.updateChildValues(cryptotab)
                                    
                                } else {
                                    
                                    if cryptoTab3 == "0" {
                                        
                                        let cryptotype = self.UnVerifiedCoinTextField.text
                                        let cryptotab = ["3": cryptotype]
                                        let ref = CryptoTabRef.updateChildValues(cryptotab)
                                        
                                        

                                        
                                    } else {
                                        
                                        if cryptoTab4 == "0" {
                                            
                                            let cryptotype = self.UnVerifiedCoinTextField.text
                                            let cryptotab = ["4": cryptotype]
                                            let ref = CryptoTabRef.updateChildValues(cryptotab)
                                            
                                            
                                        } else {
                                            
                                            print("Unable to add coin...")

                                        }

                                    }

                                }
                            }
                        }
                            }
                        }
                    }
                }
            }
    }
    
    func configureViewComponents() {
        view.backgroundColor = UIColor.mainBlack()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Crypto Cove"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor.mainGreyLight()
        
        view.addSubview(UnVerifiedCoinContainerView)
        UnVerifiedCoinContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 96, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        UnVerifiedCoinContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(AddUnVerifiedCoinButton)
        AddUnVerifiedCoinButton.anchor(top: UnVerifiedCoinContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(Dismiss)
        Dismiss.anchor(top: AddUnVerifiedCoinButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 5)
        
        
        
    }
}
