//
//  WalletController.swift
//  CryptoCove
//
//  Created by Jonathan Dominic Pasquin on 8/2/20.
//

import Foundation
import UIKit
import Firebase

class WalletController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        
    }
    
    func configureViewComponents() {
        view.backgroundColor = UIColor.mainBlack()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        navigationItem.title = "Crypto Cove"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor.mainGrey()
        
    }
    
}
