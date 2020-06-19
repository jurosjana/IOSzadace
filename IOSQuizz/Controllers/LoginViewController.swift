//
//  LoginViewController.swift
//  IOSQuizz
//
//  Created by Jana on 29/05/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var UsernameTF: UITextField!
    
    
    @IBOutlet weak var PasswordTF: UITextField!
    
    @IBOutlet weak var WrongLabel: UILabel!{
        didSet {
            WrongLabel.isHidden = true
            WrongLabel.numberOfLines = 0
            WrongLabel.sizeToFit()
        }
    }
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBAction func Login(_ sender: Any) {
        
        
        guard let username = self.UsernameTF.text else { return }
        guard let password = self.PasswordTF.text else { return }
        login(username: username, password: password, completion: {log in
            if(log == true){
                DispatchQueue.main.async {
                self.animateEverythingOut(completion: {
                    _ in
                        UIApplication.shared.windows.first!.rootViewController = TabBarViewController()
                    })
                }
                
            } else {
                DispatchQueue.main.async {
                     self.WrongLabel.isHidden = false;
                     self.UsernameTF.text = "";
                     self.PasswordTF.text = "";
                }
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        
       self.UsernameTF.center = CGPoint(x: -UsernameTF.frame.size.width, y: UsernameTF.frame.origin.y+UsernameTF.frame.size.height/2)
        self.PasswordTF.center = CGPoint(x: -PasswordTF.frame.size.width, y: PasswordTF.frame.origin.y+PasswordTF.frame.size.height/2)
        //self.UsernameTF.alpha = 0.0
        //self.PasswordTF.alpha = 0.0
       // self.titleLabel.alpha = 0.0
        self.titleLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    }
    
    
    override func viewDidLoad() {
        self.UsernameTF.alpha = 0.0
        self.PasswordTF.alpha = 0.0
        titleLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        animateEverythingIn()
    }
    
    
    func animateEverythingIn() {
        UIView.animate(withDuration: 1, delay: 0.3, animations: {
            self.UsernameTF.transform = CGAffineTransform.identity.translatedBy(x: self.UsernameTF.frame.size.width+self.view.frame.size.width*0.5, y: 0)
            self.UsernameTF.alpha = 1
            self.titleLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
           
        }) { _ in

        }
        
        UIView.animate(withDuration: 1, delay:0.7, animations: {
            self.PasswordTF.transform = CGAffineTransform(translationX: self.PasswordTF.frame.size.width+self.view.frame.size.width*0.5, y: 0)
            self.PasswordTF.alpha = 1
           
        }) { _ in
        }
    }

    
    func animateEverythingOut(completion: ((Bool)->Void)?){
        UIView.animate(withDuration: 1, delay:0.0, animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -800)
        }) { _ in
        }
        
        UIView.animate(withDuration: 1, delay:0.2, animations: {
            self.UsernameTF.center = CGPoint(x: self.view.frame.size.width/2+self.UsernameTF.frame.width/2, y: self.PasswordTF.frame.origin.y+self.UsernameTF.frame.size.height/2)
            self.UsernameTF.transform = CGAffineTransform(translationX: 0, y: -800)
            self.UsernameLabel.transform = CGAffineTransform(translationX: 0, y: -800)
        }) { _ in
        }
        
        UIView.animate(withDuration: 1, delay:0.4, animations: {
            self.PasswordTF.center = CGPoint(x: self.view.frame.size.width/2+self.PasswordTF.frame.width/2, y: self.PasswordTF.frame.origin.y+self.PasswordTF.frame.size.height/2)
            self.PasswordTF.transform = CGAffineTransform(translationX: 0, y: -800)
            self.PasswordLabel.transform = CGAffineTransform(translationX: 0, y: -800)
            }) { _ in
        }
        
        UIView.animate(withDuration: 1, delay:0.6, animations: {
                   self.LoginButton.transform = CGAffineTransform(translationX: 0, y: -800)
        }, completion:completion)
        
    }
    
}
    
   

