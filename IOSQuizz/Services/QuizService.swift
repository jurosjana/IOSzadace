//
//  QuizService.swift
//  IOSQuizz
//


import Foundation
import UIKit



class QuizService{
    
    func fetchQuizzes(completion: @escaping (([Quiz]?) -> Void)) -> Void{
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        if let url = URL(string:urlString){
            let request = URLRequest(url:url)
            print("Creating data task")

            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("fetched")
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let resultsList = json as? [String:Any],
                            let results = resultsList["quizzes"] as? [[String:Any]]{
                            let quizzes = results.map({json -> Quiz? in
                                //print(json)
                                 let quiz = Quiz(json: json)
                                 return quiz
                            }).filter {$0 != nil} .map { $0! }
                            completion(quizzes)
                        } else {
                            completion(nil)
                        }
                    } catch {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
        
    }
            
                    
             


    func fetchImage(urlString: String, completion: @escaping ((UIImage?) -> Void)){
        

        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                //print("fetched image")
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                    //print("completion called")
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
    }
}


