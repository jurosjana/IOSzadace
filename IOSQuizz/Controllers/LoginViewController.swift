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
    
    
    @IBOutlet weak var UsernameTF: UITextField!
    
    
    @IBOutlet weak var PasswordTF: UITextField!
    
    @IBOutlet weak var WrongLabel: UILabel!{
        didSet {
            WrongLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBAction func Login(_ sender: Any) {
        guard let username = self.UsernameTF.text else { return }
        guard let password = self.PasswordTF.text else { return }
        login(username: username, password: password)
    }
    
    func login(username: String, password:String) {
            
        let urlString = "https://iosquiz.herokuapp.com/api/session/?"+"username="+username+"&password="+password;
        
                    
        let parameters = ["username": username, "password": password]

        if let url = URL(string: urlString) {

            let session = URLSession.shared

            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

           
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        //print(json)
                        if let token = json["token"] as? String,
                             let id = json["user_id"] as? Int{
                                let userDefaults = UserDefaults.standard;
                                userDefaults.set(token, forKey: "token");
                                userDefaults.set(id, forKey: "id");
                                print(userDefaults.string(forKey: "token") as Any)
                                print(userDefaults.string(forKey: "id") as Any)
                            
                            DispatchQueue.main.async {
                                let vc = ListaKvizovaController(viewModel: QuizViewModel());
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            
                        } else {
                            DispatchQueue.main.async {
                                 self.WrongLabel.isHidden = false;
                                 self.UsernameTF.text = "";
                                 self.PasswordTF.text = "";
                            }
            
                        }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
    }
}
