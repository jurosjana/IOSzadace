//
//  Question.swift
//  IOSQuizz


import Foundation

class Question {
    let answers : [String]
    let correctAnswer : Int
    let id : Int
    let question : String
    
    init?(json: Any){
        if let jsonDict = json as? [String: Any],
           let answers = jsonDict["answers"] as? [String],
           let correctAnswer = jsonDict["correct_answer"] as? Int,
           let id = jsonDict["id"] as? Int,
           let question = jsonDict["question"] as? String
        {
            self.answers = answers;
            self.correctAnswer = correctAnswer;
            self.id = id;
            self.question = question;
        }
        else{
            return nil;
        }
    }
    
    init(answers:[String], correctAnswer : Int,id : Int,question : String){
        self.answers = answers;
        self.correctAnswer = correctAnswer;
        self.id = id;
        self.question = question;
    }

}


