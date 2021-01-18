//
//  Extensions.swift
//  CryptoCove
//
//  Created by Jonathan Dominic Pasquin on 7/15/20.
//

import Foundation
import UIKit
import Firebase

extension UIView {

func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
        self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    
    if let left = left {
        self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    
    if let bottom = bottom {
        bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
    }
    
    if let right = right {
        rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
    }
    
    if width != 0 {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    if height != 0 {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
    
    func coinContainerView(view: UIView, _ cryptotab1: UIView, _ cryptotab2: UIView, _ cryptotab3: UIView, _ cryptotab4: UIView
    ) -> UIView {
        view.backgroundColor = .clear
        
        view.addSubview(cryptotab1)
    cryptotab1.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 120, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 150, height: 150)
    
        view.addSubview(cryptotab2)
    cryptotab2.anchor(top: cryptotab1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: -35, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 150, height: 150)
    
        view.addSubview(cryptotab3)
    cryptotab3.anchor(top: cryptotab2.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: -35, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 150, height: 150)
    
        view.addSubview(cryptotab4)
    cryptotab4.anchor(top: cryptotab3.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: -35, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 150, height: 150)
        
        return view
}
    
    func textCoinContainerView(view: UIView, _ optionimage: UIImage, _ cryptotype: UILabel, _ cryptoprice: UILabel, _ currencytype: UILabel) -> UIView {
        view.backgroundColor = .clear
        
        view.addSubview(cryptotype)
        cryptotype.textColor = .mainBlue()
        cryptotype.font = UIFont.systemFont(ofSize: 20)
        cryptotype.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        cryptotype.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        //let cryptoimageView = UIImageView()
        //cryptoimageView.image = cryptoimage
        //cryptoimageView.alpha = 0.78
        //view.addSubview(cryptoimageView)
        //cryptoimageView.anchor(top: cryptotype.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 24, height: 24)
        
        let optionimageView = UIImageView()
        optionimageView.image = optionimage
        optionimageView.alpha = 1
        view.addSubview(optionimageView)
        optionimageView.anchor(top: cryptotype.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)

        
        view.addSubview(cryptoprice)
        cryptoprice.textColor = .white
        cryptoprice.font = UIFont.systemFont(ofSize: 22)
        cryptoprice.anchor(top: cryptotype.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        cryptoprice.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        view.addSubview(currencytype)
        currencytype.textColor = .white
        currencytype.font = UIFont.systemFont(ofSize: 16)
        currencytype.alpha = 0.78
        currencytype.anchor(top: cryptoprice.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        currencytype.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 1, alpha: 0.87)
        view.addSubview(separatorView)
        separatorView.anchor(top: currencytype.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 24, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.75)
        
        return view
    }
    
    func textSansImageContainerView(view: UIView, _ textField: UITextField) -> UIView {
        view.backgroundColor = .clear
        
        view.addSubview(textField)
        textField.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 1, alpha: 0.87)
        view.addSubview(separatorView)
        separatorView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.75)
        
        return view
    }
    
    func textContainerView(view: UIView, _ image: UIImage, _ textField: UITextField) -> UIView {
        view.backgroundColor = .clear
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.87
        view.addSubview(imageView)
        imageView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(textField)
        textField.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 1, alpha: 0.87)
        view.addSubview(separatorView)
        separatorView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.75)
        
        return view
    }
    
}
//2AC192

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func mainBlue() -> UIColor {
        return UIColor.rgb(red: 0, green: 150, blue: 255)
    }
    
    static func mainGreen() -> UIColor {
        return UIColor.rgb(red: 42, green: 193, blue: 146)
    }
    
    static func mainGrey() -> UIColor {
        return UIColor.rgb(red: 28, green: 28, blue: 28)
    }
    
    static func mainBlack() -> UIColor {
        return UIColor.rgb(red: 34, green: 38, blue: 39)
    }
    
    static func mainGreyLight() -> UIColor {
        return UIColor.rgb(red: 164, green: 168, blue: 169)
    }
    
    static func googleRed() -> UIColor {
        return UIColor.rgb(red: 220, green: 78, blue: 65)
    }
    
    static func menuGrey() -> UIColor {
        return UIColor.rgb(red: 48, green: 50, blue: 52)
    }
}

extension UITextField {
    func textField(withPlaceolder placeholder: String, isSecureTextEntry: Bool) -> UITextField {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.isSecureTextEntry = isSecureTextEntry
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }
    
}

public extension UINavigationController {

    /**
        This makes the font super cool.
     */
    func popToAddCoinController(transitionType type: String = CATransitionType.push.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        self.view.layer.add(transition, forKey: kCATransition)
        self.pushViewController(AddCoinController(), animated: false)
      }
    
    private func addTransition(transitionType type: String = CATransitionSubtype.fromTop.rawValue, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType(rawValue: type)
        self.view.layer.add(transition, forKey: nil)
    }
    
}
