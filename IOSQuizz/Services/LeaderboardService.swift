//
//  LeaderboardService.swift
//  IOSQuizz
//
//  Created by Jana on 15/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation

class LeaderboardService {
    func fetchLeaderboard(quizId: Int, completion: @escaping (([LeaderboardRow]?) -> Void)) {
       
        let urlString = "https://iosquiz.herokuapp.com/api/score?"+"quiz_id="+String(quizId)

        if let url = URL(string:urlString){
            var request = URLRequest(url:url)
            request.httpMethod = "GET"

            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let userDefaults = UserDefaults.standard;
            let token = userDefaults.string(forKey: "token")!

            request.addValue(token, forHTTPHeaderField: "Authorization")
            print("Creating data task")

            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("fetched")
                if let data = data {
                    //print(data)
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        //print(json)
                        if let resultsList = json as? [Any]{
                            //print(resultsList)
                            //var scores : [LeaderboardRow] = []
                            let scores = Array(resultsList.map({json -> LeaderboardRow? in
                                let row = LeaderboardRow(json: json)
                                //print(row?.score)
                                return row
                            }).filter {$0 != nil}.map { $0!}.sorted { (l1, l2) -> Bool in
                                l1.score > l2.score
                            }.prefix(20))
                            //print(scores)
                            completion(scores)
                            
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
}
            
                    

