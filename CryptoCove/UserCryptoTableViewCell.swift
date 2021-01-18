//
//  UserCryptoTableViewCell.swift
//  CryptoCove
//
//  Created by Jonathan Dominic Pasquin on 7/25/20.
//

import Foundation
import UIKit
import Firebase

class UserCryptoTableViewCell: UITableViewCell {
    
    let useruid = Auth.auth().currentUser?.uid
    let emptyImage = UIImage(contentsOfFile: "")
    //
    
    var cryptotab: UserCrypto.UserCryptoTab? {
        didSet {
            
            CryptoTabRef.child("currencyType").observeSingleEvent(of: .value) { (snapshot) in
                guard let currencyType = snapshot.value as? String else { return }
                    
                    guard let contactItem = self.cryptotab else {return}
                    
            if let cryptotype = contactItem.cryptotype {
                
                CryptoTabRef.child("\(cryptotype)").observeSingleEvent(of: .value) { (snapshot) in
                    guard let cryptoTab = snapshot.value as? String else { return }
                    
                    let apiCryptoType  = cryptoTab
                    let apiCurrencyType = currencyType
                    let apiurl = "https://min-api.cryptocompare.com/data/price?fsym=" + apiCryptoType + "&tsyms=" + apiCurrencyType
                    let apiURL = URL(string: apiurl)
                
                    self.cryptotypeLabel.text = "\(cryptoTab)"
                    
                    self.makeValueGETRequest(url: apiURL!) { (value) in
                    DispatchQueue.main.async {
                    self.cryptopriceLabel.text = self.formatAsCurrencyString(value: value) ?? "Failed"
                    self.currencytypeLabel.text = "\(currencyType)"
                    
                        if self.cryptotypeLabel.text == "0" {
                            self.cryptoContainerView.alpha = 0
                            self.cryptoimageView.alpha = 0
                            
                        } else {
                            self.cryptoContainerView.alpha = 1
                            self.cryptoimageView.alpha = 1
                            
                        }
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    lazy var cryptoContainerView: UIView = {
        let view = UIView()
        view.alpha = 1
// this will make sure its children do not go out of the boundary
        return view.textCoinContainerView(view: view, #imageLiteral(resourceName: "OptionIcon"), cryptotypeLabel, cryptopriceLabel, currencytypeLabel)
    }()
    
    let cryptoimageView: UIImageView = {
    let iv = UIImageView()
        iv.image = UIImage(named: "StonksArrows")
        iv.alpha = 1
        return iv
    }()
    
    let cryptotypeLabel: UILabel = {
        let cryptotype = UILabel()
        cryptotype.textColor = .mainBlue()
        cryptotype.font = UIFont.systemFont(ofSize: 22)
        return cryptotype
        }()
    
    let cryptopriceLabel: UILabel = {
        let cryptotype = UILabel()
        cryptotype.textColor = .white
        cryptotype.font = UIFont.systemFont(ofSize: 22)
        return cryptotype
        }()
    
    let currencytypeLabel: UILabel = {
        let cryptotype = UILabel()
        cryptotype.textColor = .white
        cryptotype.text = "CAD"
        cryptotype.font = UIFont.systemFont(ofSize: 16)
        return cryptotype
        }()
    
    func makeValueGETRequest(url: URL, completion: @escaping (_ value: NSNumber?) -> Void) {
        
        Database.database().reference().child("Users").child(useruid!).child("IOS").child("currencyType").observeSingleEvent(of: .value) { (snapshot) in
        guard let currencyType = snapshot.value as? String else { return }
            
        let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                completion(nil)
                print(error?.localizedDescription ?? "")
                return
            }
            
            do {
                // Unwrap the JSON dictionary and read the USD key which has the value of Ethereum
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                      
                    let value = json[currencyType] as? NSNumber else {
                        completion(nil)
                        return
                }
                completion(value)
            } catch  {
                // If we couldn't serialize the JSON set the value in the completion as nil and print the error
                completion(nil)
                print(error.localizedDescription)
            }
        }

        request.resume()
            
    }
}
    /// Takes an optional NSNumber and converts it to USD String
    ///
    /// - Parameter value: The NSNumber to convert to a USD String
    /// - Returns: The USD String or nil in the case of failure
    func formatAsCurrencyString(value: NSNumber?) -> String? {
        /// Construct a NumberFormatter that uses the US Locale and the currency style
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency

        // Ensure the value is non-nil and we can format it using the numberFormatter, if not return nil
        guard let value = value,
            let formattedCurrencyAmount = formatter.string(from: value) else {
                return nil
        }
        

        return formattedCurrencyAmount
        }
    
//    func animateUserCrypto() {
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//
//        UIView.animate(withDuration: 0.25, animations: {
//
//
//            })
//        })
//
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.mainBlack()
        
        
        //let cryptoimageView = UIImageView()
        //cryptoimageView.image = cryptoimage
        //cryptoimageView.alpha = 0.78
        
        
        addSubview(cryptoimageView)
        cryptoimageView.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 24, height: 24)
        addSubview(cryptoContainerView)
        cryptoContainerView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 150, height: 150)
        cryptoContainerView.translatesAutoresizingMaskIntoConstraints = false
        cryptoContainerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }

}
