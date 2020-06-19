//
//  SceneDelegate.swift
//  IOSQuizz
//


import Foundation
import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      guard let winScene = (scene as? UIWindowScene) else { return }
    
      let win = UIWindow(windowScene: winScene)
    
    //ako treba login root je LoginViewController
    let userDefaults = UserDefaults.standard;
    if userDefaults.string(forKey: "token") == nil{
     win.rootViewController = LoginViewController()
    }
    //ako ne treba login, tab bar je rootviewcontroller
    else{
      win.rootViewController = TabBarViewController()
    }
      win.makeKeyAndVisible()
      window = win
  }
}
