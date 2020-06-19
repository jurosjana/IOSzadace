//
//  LeaderboardHeader.swift
//  IOSQuizz
//
//  Created by Jana on 16/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardHeader : UIView {

    var titleLabel: UILabel!
    var rankLabel: UILabel!
    var usernameLabel: UILabel!
    var scoreLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.text = "20 Best rankings"
        titleLabel.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        titleLabel.sizeToFit()
        self.addSubview(titleLabel)
        
        
        rankLabel = UILabel()
        rankLabel.font = UIFont.systemFont(ofSize: 20)
        rankLabel.text = "Rank:"
        rankLabel.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        rankLabel.sizeToFit()
        self.addSubview(rankLabel)
        
        usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFont(ofSize: 20)
        usernameLabel.text = "Username:"
        usernameLabel.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        usernameLabel.sizeToFit()
        self.addSubview(usernameLabel)
        
        scoreLabel = UILabel()
        scoreLabel.font = UIFont.systemFont(ofSize: 20)
        scoreLabel.text = "Score:"
        scoreLabel.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        scoreLabel.sizeToFit()
        self.addSubview(scoreLabel)
        
        //prvi red
        titleLabel.autoAlignAxis(.vertical, toSameAxisOf: self)
        titleLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 15)
        //drugi  red
         rankLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 15)
        rankLabel.autoPinEdge(.left, to: .left, of: self, withOffset: 10)
        usernameLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 15)
        usernameLabel.autoPinEdge(.left, to: .right, of: rankLabel, withOffset: 30)
        scoreLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 15)
        scoreLabel.autoPinEdge(.right, to: .right, of: self, withOffset: -40)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
