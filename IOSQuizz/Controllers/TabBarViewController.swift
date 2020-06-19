//
//  TabBarViewController.swift
//  IOSQuizz
//
//  Created by Jana on 16/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController:UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = SettingsEkran()
        let kvizovi = ListaKvizovaController(viewModel: QuizViewModel())
        let search = SearchEkran(viewModel: QuizViewModel())
        
        let nc = UINavigationController(rootViewController: kvizovi)
        let nc2 = UINavigationController(rootViewController: search)
        
        
        nc.navigationItem.title = "Home"
        settings.navigationItem.title = "Settings"
        nc2.navigationItem.title = "Search"
        nc.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        nc2.tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 0)
        settings.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 0)
        
        let color = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        let attributesNormal = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22.0)]
        let attributesSelected = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22.0), NSAttributedString.Key.foregroundColor: color]
        
        let appearance = UITabBarItem.appearance()
        appearance.setTitleTextAttributes(attributesNormal, for: .normal)
        appearance.setTitleTextAttributes(attributesSelected, for: .selected)
        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -15)
        
       
        self.viewControllers = [nc, settings, nc2]
        self.selectedViewController = nc
        
        
                
    }
    
}
