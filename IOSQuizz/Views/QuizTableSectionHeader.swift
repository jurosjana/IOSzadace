//
//  QuizTableSectionHeader.swift
//  IOSQuizz
//
//  Created by Jana on 05/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit

class QuizTableSectionHeader: UIView {

    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(titleLabel)
        titleLabel.autoAlignAxis(.horizontal, toSameAxisOf: self)
        titleLabel.autoAlignAxis(.vertical, toSameAxisOf: self)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


