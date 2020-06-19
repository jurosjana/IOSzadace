//
//  Questions.swift
//  IOSQuizz
//
//  Created by Jana on 17/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation

public class Questions : NSObject, NSCoding {
    
    var questions: [Question] = []
    
    enum Key:String {
        case questions = "questions"
    }
    
    init(questions: [Question]){
        self.questions = questions
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(questions, forKey: Key.questions.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let questions = coder.decodeObject(forKey: Key.questions.rawValue) as! [Question]
        self.init(questions: questions)
    }
    
    
}
