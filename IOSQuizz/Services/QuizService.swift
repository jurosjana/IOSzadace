//
//  QuizService.swift
//  IOSQuizz
//


import Foundation
import UIKit



class QuizService{
    
    func fetchQuizzes(completion: @escaping (([Quiz]?) -> Void)) {
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        if let url = URL(string:urlString){
            let request = URLRequest(url:url)
            print("Creating data task")

            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("fetched")
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        if let resultsList = json as? [String:Any],
                            let results = resultsList["quizzes"] as? [[String:Any]]{
                            let quizzes = results.map({json -> Quiz? in
                                //print(json)
                                let quiz = Quiz.createFrom(json: json)
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
    
    func sendAnswers(parameters: [String:Any], completion: @escaping (ServerResponse?) -> Void){
        
        let userDefaults = UserDefaults.standard
        let token = userDefaults.string(forKey: "token")
        
       let url = URL(string: "https://iosquiz.herokuapp.com/api/result")!
       
       let session = URLSession.shared

       var request = URLRequest(url: url)
       request.httpMethod = "POST" //set http method as POST

       do {
           request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        //print(request.httpBody as Any)
       } catch let error {
           print(error.localizedDescription)
       }

       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       request.addValue(token!, forHTTPHeaderField: "Authorization")
       
        //print(request.allHTTPHeaderFields as Any)

       //create dataTask using the session object to send data to the server
       let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

           guard error == nil else {
               return
           }

           guard let data = data else {
               return
           }

           do {
               
               if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                   print(json)
               }
               if let response = response {
                   let nsHTTPResponse = response as! HTTPURLResponse
                   let statusCode = nsHTTPResponse.statusCode
                   print ("status code = \(statusCode)")
                   let response = ServerResponse(rawValue: statusCode)
                   
                    completion(response)
                       
               } else {
                completion(nil)
            }
           } catch let error {
               print(error.localizedDescription)
           }
       })
       task.resume()
    }
}


