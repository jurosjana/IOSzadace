//
//  LeaderboardTableViewCell.swift
//  IOSQuizz
//
//  Created by Jana on 15/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit
import PureLayout


class LeaderboardTableViewCell : UITableViewCell {
    
   
    @IBOutlet weak var indexLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.usernameLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.scoreLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.indexLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    override func prepareForReuse() {  //izbrisi sve
        super.prepareForReuse()
        usernameLabel.text = ""
        scoreLabel.text = ""
        
    }
    
    
    
    func setup(withScore row: LeaderboardRow, index: Int) {  //upisi neki review
        usernameLabel.text = String(row.username)
        usernameLabel.sizeToFit()
        scoreLabel.text = String(row.score)
        scoreLabel.sizeToFit()
        indexLabel.text = String(index+1)
        if(index % 2 == 0){
             self.backgroundColor = #colorLiteral(red: 1, green: 0.9919539642, blue: 0.8701620708, alpha: 0.9963613014)
        } else {
            self.backgroundColor = #colorLiteral(red: 0.9937737944, green: 0.9560003593, blue: 0.9385668779, alpha: 1)
        }
    }
}
