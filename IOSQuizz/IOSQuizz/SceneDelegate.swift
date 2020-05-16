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

      // Create the root view controller as needed
      let vc = InitialViewController()
      let nc = UINavigationController(rootViewController: vc)

      // Create the window. Be sure to use this initializer and not the frame one.
      let win = UIWindow(windowScene: winScene)
      win.rootViewController = nc
      win.makeKeyAndVisible()
      window = win
  }
}
