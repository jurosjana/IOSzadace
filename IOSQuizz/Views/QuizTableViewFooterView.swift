//
//  QuizTableViewFooterView.swift
//  IOSQuizz
//
//  Created by Jana on 06/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewFooterViewDelegate: class {
    func logOut()
}

class QuizTableViewFooterView : UIView {
    
    var logOutButton: UIButton!
    
    weak var delegate: TableViewFooterViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        logOutButton = UIButton()
        logOutButton.setTitle("Log out", for: UIControl.State.normal)
        logOutButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        addSubview(logOutButton)
        logOutButton.autoAlignAxis(.vertical, toSameAxisOf: self)
        logOutButton.autoPinEdge(.top, to: .top, of: self, withOffset: 14.0)
       logOutButton.addTarget(self, action: #selector(logOutButtonTapped(_:)), for: UIControl.Event.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func logOutButtonTapped(_ sender: UIButton) {
        print("log out button tapped")
        delegate?.logOut()
    }
    
}
