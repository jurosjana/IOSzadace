//
//  QuizTableViewCell.swift
//  IOSQuizz
//
//  Created by Jana on 30/05/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class QuizTableViewCell:UITableViewCell{
    
   
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.numberOfLines=0
        }
    }
    
    @IBOutlet weak var quizImageView: UIImageView!
    override func awakeFromNib() {  //inicijalizacija fonta
        super.awakeFromNib()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        titleLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = UIColor.gray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
    }
    
    override func prepareForReuse() {  //izbrisi sve
        super.prepareForReuse()
        titleLabel.text = ""
        levelLabel.text = ""
        descriptionLabel.text = ""
        quizImageView?.image = nil
    }
    
    
    
    func setup(withQuiz quiz: QuizCellModel) {  //upisi neki review
        titleLabel.text = quiz.title
        titleLabel.sizeToFit()
        descriptionLabel.text = quiz.description
        descriptionLabel.sizeToFit()
        levelLabel.text = quiz.level
            
        if
            let url = quiz.imageUrl {
            quizImageView.kf.setImage(with: url)
            }
    }
    
}


