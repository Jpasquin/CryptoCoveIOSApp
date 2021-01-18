//
//  UserCryptoAPI.swift
//  CryptoCove
//
//  Created by Jonathan Dominic Pasquin on 7/25/20.
//

import Foundation
import UIKit
import Firebase

class UserCryptoAPI {

    
    class userCryptoAPI: UITableViewController {
        
        
        var cryptos = [
            
            
            UserCrypto.UserCryptoTab(cryptotype: "0"),
            UserCrypto.UserCryptoTab(cryptotype: "1"),
            UserCrypto.UserCryptoTab(cryptotype: "2"),
            UserCrypto.UserCryptoTab(cryptotype: "3"),
            UserCrypto.UserCryptoTab(cryptotype: "4"),
            
        ] as [Any]
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return cryptos.count
        
        }
    }
}
