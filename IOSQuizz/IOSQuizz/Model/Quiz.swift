//
//  Quiz.swift
//  IOSQuizz
//
//  Created by Jana on 14/05/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit

class Quiz {
    let category : Category
    let description : String
    let id : Int
    var image : UIImage
    let level : Int
    let questions : [Question]
    let title : String
    
    init?(json: Any) {
        if let jsonDict = json as? [String: Any],
            let category = jsonDict["category"] as? Category,
            let description = jsonDict["description"] as? String,
            let id = jsonDict["id"] as? Int,
            let imageUrlString = jsonDict["image"] as? String,
            let level = jsonDict["level"] as? Int,
            let questions = jsonDict["questions"] as? [Any],
            let title = jsonDict["title"] as? String
            {
                //nabavi sliku
                if let url = URL(string: imageUrlString){
                    let request = URLRequest(url: url)
                    
                    let dataTask = URLSession.shared.dataTask(with: request){
                        (data, response, error) in
                        if let data = data{
                            let image = UIImage(data: data)
                            if let image = image{
                                self.postavi(image: image)
                            }
                        }
                        
                    }
                    dataTask.resume();
                }
                
                //spremi pitanja
                for i in questions{
                    guard let question = Question(json: i) else { return nil }
                    self.questions.append(question);
                }
                self.category = category
                self.description = description
                self.id = id
                self.level = level
                self.title = title
        }
    }
    
    func postavi(image: UIImage){
        self.image = image
    }
}

enum Category{
    
}
