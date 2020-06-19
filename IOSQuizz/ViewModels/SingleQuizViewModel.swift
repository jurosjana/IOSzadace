//
//  SingleQuizViewModel.swift
//  IOSQuizz
//
//  Created by Jana on 01/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation

class SingleQuizViewModel {
    var quiz: Quiz? = nil
        
    
    init(quiz: Quiz) {
        self.quiz = quiz
    }
    

    var quizTitle: String {
        if let title = quiz?.title {
            return title.uppercased()
        }
        else {
            return ""
        }
    }
    
    var descritpion: String {
        return quiz?.description ?? ""
    }
    
    var imageUrl: URL? {
        if let urlString = quiz?.imageUrl {
            return URL(string: urlString)
        }
        return nil
    }
    
    var questions : [Question]{
        return (quiz?.questions.questions ?? [])  
    }
}
