import Foundation
import SwiftUI

class Quiz2 {
    let category : QuizCategory
    let description : String
    let id : Int
    let level : Int
    var questions : [Question] = []
    let title : String
    let imageUrl: String?
    
    init?(json: Any) {
        if let jsonDict = json as? [String: Any],
            let description = jsonDict["description"] as? String,
            let id = jsonDict["id"] as? Int,
            let imageUrlString = jsonDict["image"] as? String,
            let level = jsonDict["level"] as? Int,
            let questions = jsonDict["questions"] as? [Any],
            let title = jsonDict["title"] as? String,
            let category = jsonDict["category"] as? String
            {
                switch(category){
                case "SCIENCE":
                    self.category = .SCIENCE
                case "SPORTS":
                    self.category = .SPORTS
                default:
                    self.category = .DEFAULT
                }
                self.description = description
                self.id = id
                self.level = level
                self.title = title
                self.imageUrl = imageUrlString
                
                //spremi pitanja
                for i in questions{
                    guard let question = Question(json: i) else { return nil }
                    self.questions.append(question);
                }
                
        } else {
            return nil;
        }
    }
    /*
    init(title: String, description: String, imageUrl: String, level:Int) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.level = level
    }
    */
    
    
    
    
    }

 
    


