//
//  QuizService.swift
//  IOSQuizz
//


import Foundation
import UIKit



func fetchQuizzes(completion: @escaping (([OneQuiz]?) -> Void)){
    var listQuiz : [OneQuiz] = []
    let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
    
            
    if let url = URL(string:urlString){
        
        let request = URLRequest(url:url)
        
        print("Creating data task")
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("fetched")
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]{
                        
                        if let quizzes = json["quizzes"] as? [Any]{
                            //print(quizzes[0])
                            
                            for i in quizzes {
                                if let quiz = i as? [String : Any],
                                    let quiz1 = OneQuiz(json: quiz){
                                    //print(quiz1.category)
                                    listQuiz.append(quiz1)
                                    }
                            }
                            if (listQuiz.count > 0){
                                completion(listQuiz)
                            } else {
                                completion(nil)
                            }
                        } else {
                            completion(nil)
                        }
                    }
                }catch {
                        print("catch")
                        completion(nil)
                }
                
            } else {
                completion(nil)
            }
           
        }
        
        print("resuming data task")
                dataTask.resume()
    
    } else {
        completion(nil)
    }
    
}


func fetchImage(urlString: String, completion: @escaping ((UIImage?) -> Void)){
    

    if let url = URL(string: urlString) {
            
        
        let request = URLRequest(url: url)
        
        print("creating data task")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("fetched image")
            if let data = data {
                let image = UIImage(data: data)
                completion(image)
                print("completion called")
            } else {
                completion(nil)
            }
        }
       
        
        print("resuming data task")
        
        dataTask.resume()
    } else {
        completion(nil)
    }
}


