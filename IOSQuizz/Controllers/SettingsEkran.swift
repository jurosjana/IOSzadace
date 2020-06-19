//
//  SettingsEkran.swift
//  IOSQuizz
//
//  Created by Jana on 16/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit


class SettingsEkran : UIViewController {
    
    var logoutButton: UIButton!
  
    var usernameLabel: UILabel!
    
    var username: UILabel!

    
   
        
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9578640546, green: 0.9080962065, blue: 0.9040285305, alpha: 1)
        logoutButton = UIButton()
        usernameLabel = UILabel()
        username = UILabel()
        self.view.addSubview(logoutButton)
        self.view.addSubview(usernameLabel)
        self.view.addSubview(username)
        bindViewModel()
        
    }
    
    
    func bindViewModel() {
        
        let guide = view.safeAreaLayoutGuide

        usernameLabel.text = "Username:"
        let userDefaults = UserDefaults.standard
        username.text = userDefaults.string(forKey: "username")
        logoutButton.setTitle("Log out", for: .normal)
        username.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        logoutButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        usernameLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
       
        usernameLabel.autoPinEdge(.top, to: .top, of: self.view, withOffset: 200)
        usernameLabel.autoPinEdge(.left, to: .left, of: self.view, withOffset: 50)
       username.autoPinEdge(.top, to: .top, of: self.view, withOffset: 200)
        username.autoPinEdge(.right, to: .right, of: self.view, withOffset: -50)
        
        logoutButton.autoPinEdge(.top, to: .bottom, of: username, withOffset: 40)
        logoutButton.autoPinEdge(.right, to: .right, of: self.view, withOffset: -50)
             
 
        
      
        logoutButton.addTarget(self, action: #selector(logout), for: UIControl.Event.touchUpInside)
        
      
        }
    
    @objc func logout(sender: UIButton){
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "token")
            userDefaults.removeObject(forKey: "username")
            userDefaults.removeObject(forKey: "user_id")
        UIApplication.shared.windows.first!.rootViewController = LoginViewController()
    }
        
        
}
    
    
    
 
    
 
