//
//  Quiz.swift
//  IOSQuizz
//
//  Created by Jana on 17/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Quiz)
public class Quiz: NSManagedObject {
    
    class func getEntityName() -> String {
        return "Quiz"
    }
    
    class func firstOrCreate(withTitle title: String) -> Quiz? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", title)
        request.returnsObjectsAsFaults = false

        do {
            let quizzes = try context.fetch(request)
            if let quiz = quizzes.first {
                return quiz
            } else {
                let newQuiz = Quiz(context: context)
                return newQuiz
            }
        } catch {
            return nil
        }
    }
    
    class func createFrom(json: [String: Any]) -> Quiz? {
        if let jsonDict = json as? [String: Any],
           let description = jsonDict["description"] as? String,
           let id = jsonDict["id"] as? Int16,
           let imageUrlString = jsonDict["image"] as? String,
           let level = jsonDict["level"] as? Int16,
           let questions = jsonDict["questions"] as? [Any],
           let title = jsonDict["title"] as? String,
           let category = jsonDict["category"] as? String,
           
            let quiz = Quiz.firstOrCreate(withTitle: title) {
               switch(category){
               case "SCIENCE":
                   quiz.category = .SCIENCE
               case "SPORTS":
                   quiz.category = .SPORTS
               default:
                   quiz.category = .DEFAULT
                }
               quiz.quizDescription = description
               quiz.id = id
               quiz.level = level
               quiz.title = title
               quiz.imageUrl = imageUrlString
               
               //spremi pitanja
            var questionArray : [Question] = []
               for i in questions{
                   guard let question = Question(json: i) else { return nil }
                questionArray.append(question)
               }
            let questions = Questions(questions: questionArray)
            quiz.setValue(questions, forKey: "questions")
                do {
                    let context = DataController.shared.persistentContainer.viewContext
                    try context.save()
                    return quiz
                } catch {
                    print("Failed saving")
                    return nil
                }
           
           } else {
               return nil;
           }
    }
}


extension Quiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quiz> {
        return NSFetchRequest<Quiz>(entityName: "Quiz")
    }

    @NSManaged public var title: String?
    @NSManaged public var categoryValue: Int16
    public var category: QuizCategory {
        get {
            return QuizCategory(rawValue: self.categoryValue)!
        }
        set {
            self.categoryValue = newValue.rawValue
        }
    }
    @NSManaged public var quizDescription: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var id: Int16
    @NSManaged public var level: Int16
    @NSManaged public var questions: Questions
}

