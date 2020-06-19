//
//  Question.swift
//  IOSQuizz


import Foundation
import CoreData

class Question : NSObject,NSCoding{
    
    var answers : [String]
    var correctAnswer : Int
    var id : Int
    var question : String
    
    enum Key : String {
        case answers = "answers"
        case correctAnswer = "correctAnswer"
        case id = "id"
        case question = "question"
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.question, forKey: "question")
        coder.encode(self.id, forKey: "id")
        coder.encode(self.answers, forKey: "answers")
        coder.encode(self.correctAnswer, forKey: "correctAnswer")
        
    }
    
    public required init?(coder: NSCoder) {
        self.question = coder.decodeObject(forKey: "question") as! String
        self.correctAnswer = coder.decodeObject(forKey: "correctAnswer") as? Int ?? 0
        self.answers = (coder.decodeObject(forKey: "answers") as? [String] ?? [])
        self.id = coder.decodeObject(forKey: "id") as? Int ?? 0
    }


    
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
    
    func initWithCoder(coder: NSCoder)->Question {
        self.question = coder.decodeObject(forKey: "question") as! String
        self.correctAnswer = coder.decodeObject(forKey: "correctAnswer") as! Int
        self.answers = (coder.decodeObject(forKey: "more") as? [String])!
        self.id = coder.decodeObject(forKey: "id") as! Int
        return self
    }
    
    
    init(answers:[String], correctAnswer : Int,id : Int,question : String){
        self.answers = answers;
        self.correctAnswer = correctAnswer;
        self.id = id;
        self.question = question;
    }

}


