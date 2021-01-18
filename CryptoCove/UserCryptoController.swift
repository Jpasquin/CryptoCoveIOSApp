//
//  UserCryptoController.swift
//  CryptoCove
//
//  Created by Jonathan Dominic Pasquin on 7/26/20.
//

import Foundation
import Firebase
import UIKit
import SwiftUI

private let reuseIdentifier = "UserCryptoCell"

let useruid = Auth.auth().currentUser?.uid
let CryptoTabRef = Database.database().reference().child("Users").child(useruid!).child("IOS")
let CryptoTabRef0 = Database.database().reference().child("Users").child(useruid!).child("IOS").child("0")
let CryptoTabRef1 = Database.database().reference().child("Users").child(useruid!).child("IOS").child("1")
let CryptoTabRef2 = Database.database().reference().child("Users").child(useruid!).child("IOS").child("2")
let CryptoTabRef3 = Database.database().reference().child("Users").child(useruid!).child("IOS").child("3")
let CryptoTabRef4 = Database.database().reference().child("Users").child(useruid!).child("IOS").child("4")

class UserCryptoController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cryptos = UserCryptoAPI.userCryptoAPI().cryptos
    var pullControl = UIRefreshControl()
    let tableView = UITableView()
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
                pullControl.tintColor = UIColor.white
                pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
                if #available(iOS 10.0, *) {
                    tableView.refreshControl = pullControl
                } else {
                    tableView.addSubview(pullControl)
                }
        
        configureTableView()
        loadTableData()
        countTabs()
        

    }
    
    
    @objc func handleAddCoin() {
        navigationController?.pushViewController(AddCoinController(), animated: true)
        
    }


    @objc private func refreshListData(_ sender: Any) {
             // You can stop after API Call
        self.tableView.alpha = 0.5
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        self.pullControl.endRefreshing()
        UIView.animate(withDuration: 1.0, animations: {
            self.tableView.alpha = 1
            
        })
        
    }
    
    func insertnewitem() {
        
        let cryptoitem = AddCoinController().UnVerifiedCoinTextField.text!
        
        cryptos.insert(cryptoitem, at: 0)
        cryptos.append(AddCoinController().UnVerifiedCoinTextField.text!)
        let indexPath = IndexPath(row: cryptos.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .right)
        tableView.endUpdates()
        
        
        
    }
    
    func countTabs() {
        CryptoTabRef4.observeSingleEvent(of: .value) { (snapshot) in
            guard let cryptoTab4 = snapshot.value as? String else { return }
            
            if cryptoTab4 != "0" {
                let n = 2   //The tab number to disable
                self.tabBarController!.tabBar.items![n].isEnabled = false
                
            } else {
                let n = 2   //The tab number to enable
                self.tabBarController!.tabBar.items![n].isEnabled = true
                
            }
            

    }
}
    func loadTableData() {
        self.tableView.reloadData()
        UIView.animate(withDuration: 1.0, animations: {
            self.tableView.alpha = 1
        })
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            navigationController?.navigationBar.isHidden = true
            self.navigationController?.popToRootViewController(animated: true)
            
        } catch let error {
            print("Failed to sign out with error..", error)
        }
    }

    
    func animateUserCrypto() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.tableView.alpha = 1
            
            })
        })
    }
    
    func deleteRows() {
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
     
                        if cryptoTab4 == "0" {
                            
                            self.cryptos.remove(at: 0)
                            let indexPath = IndexPath(item: 4, section: 0)
                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                            
                            
                        } else {
                        //load user data.
                        }
                        
                        if cryptoTab3 == "0" {
                            
                            self.cryptos.remove(at: 0)
                            let indexPath = IndexPath(item: 3, section: 0)
                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                            
                        } else {
                        //load user data.
                        }
                        
                        if cryptoTab2 == "0" {
                            
                            self.cryptos.remove(at: 0)
                            let indexPath = IndexPath(item: 2, section: 0)
                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                            
                        } else {
                        //load user data.
                        }
                        
                        if cryptoTab1 == "0" {
                            
                            self.cryptos.remove(at: 0)
                            let indexPath = IndexPath(item: 1, section: 0)
                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                            
                        } else {
                        //load user data.
                        }
            
                        if cryptoTab0 == "0" {
                            
                            self.cryptos.remove(at: 0)
                            let indexPath = IndexPath(item: 0, section: 0)
                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                            
                        } else {
                            //load user data.
                                }
                            }
                        }
                    }
                }
            }
    }
    
    func arrangeTableContents() {
        
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
                
                if cryptoTab4 == "0" {
                    
                    let n = 2   //The tab number to enable
                    self.tabBarController!.tabBar.items![n].isEnabled = true
                    
                } else {
                }
                
                if cryptoTab3 == "0" {
                    
                    let newtab = ["3": cryptoTab4]
                    let oldtab = ["4": "0"]
                    
                    let n = 2   //The tab number to enable
                    self.tabBarController!.tabBar.items![n].isEnabled = true
                    
                    
                    let newref = CryptoTabRef.updateChildValues(newtab)
                    let oldref = CryptoTabRef.updateChildValues(oldtab)
                    
                    
                } else {
                }
                
                if cryptoTab2 == "0" {
                    
                    
                    let newtab = ["2": cryptoTab3]
                    let oldtab = ["3": "0"]
                    
                    let tab3 = ["3": cryptoTab4]
                    let tab4 = ["4": "0"]
                    
                    let n = 2   //The tab number to enable
                    self.tabBarController!.tabBar.items![n].isEnabled = true
                    
                    let newref = CryptoTabRef.updateChildValues(newtab)
                    let oldref = CryptoTabRef.updateChildValues(oldtab)
                    
                    let tab3ref = CryptoTabRef.updateChildValues(tab3)
                    let tab4ref = CryptoTabRef.updateChildValues(tab4)
                    
                } else {
                }
                
                if cryptoTab1 == "0" {
                    
                    let newtab = ["1": cryptoTab2]
                    let oldtab = ["2": "0"]
                    
                    let tab2 = ["2": cryptoTab3]
                    let tab3 = ["3": cryptoTab4]
                    let tab4 = ["4": "0"]
                    
                    let n = 2   //The tab number to enable
                    self.tabBarController!.tabBar.items![n].isEnabled = true
                    
                    let newref = CryptoTabRef.updateChildValues(newtab)
                    let oldref = CryptoTabRef.updateChildValues(oldtab)
                    
                    let tab2ref = CryptoTabRef.updateChildValues(tab2)
                    let tab3ref = CryptoTabRef.updateChildValues(tab3)
                    let tab4ref = CryptoTabRef.updateChildValues(tab4)
                    
                } else {
                }
                if cryptoTab0 == "0" {
        
                    let newtab = ["0": cryptoTab1]
                    let oldtab = ["1": "0"]
                    
                    let tab1 = ["1": cryptoTab2]
                    let tab2 = ["2": cryptoTab3]
                    let tab3 = ["3": cryptoTab4]
                    let tab4 = ["4": "0"]
                    
                    let n = 2   //The tab number to enable
                    self.tabBarController!.tabBar.items![n].isEnabled = true
                    
                    let newref = CryptoTabRef.updateChildValues(newtab)
                    let oldref = CryptoTabRef.updateChildValues(oldtab)
                    
                    let tab1ref = CryptoTabRef.updateChildValues(tab1)
                    let tab2ref = CryptoTabRef.updateChildValues(tab2)
                    let tab3ref = CryptoTabRef.updateChildValues(tab3)
                    let tab4ref = CryptoTabRef.updateChildValues(tab4)
                    
                } else {
                                                
                                        
                                    }

                                }
                            }
                        }
                    }
                }
    }
    
    
    func configureTableView() {
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor.mainBlack()
        navigationItem.title = "Crypto Cove"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor.mainGrey()
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        tableView.alpha = 0
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.mainBlack()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserCryptoTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        
        
        if editingStyle == .delete {
            
            self.cryptos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let cryptotab = ["\(indexPath.item)": "0"]
                let ref = CryptoTabRef.updateChildValues(cryptotab)
            
            arrangeTableContents()
        }
}

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCryptoTableViewCell
        
        cell.selectionStyle = .none
        cell.cryptotab = cryptos[indexPath.row] as? UserCrypto.UserCryptoTab
        
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}

