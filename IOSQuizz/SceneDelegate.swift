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

      //login?
    let userDefaults = UserDefaults.standard;
    let vc: UIViewController = LoginViewController();
    let vc2 = ListaKvizovaController(viewModel: QuizViewModel());
    let nc: UINavigationController
    //login je rootViewController
    nc = UINavigationController(rootViewController: vc)
    
    if userDefaults.string(forKey: "token") != nil{
        //ne treba login
        nc.pushViewController(vc2, animated: true)
    }

      let win = UIWindow(windowScene: winScene)
      win.rootViewController = nc
      win.makeKeyAndVisible()
      window = win
  }
}
