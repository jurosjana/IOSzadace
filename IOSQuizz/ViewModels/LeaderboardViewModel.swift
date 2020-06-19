//
//  LeaderboardViewModel.swift
//  IOSQuizz
//
//  Created by Jana on 15/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation

struct LeaderboardRow {
    let score: Double
    let username: Int
    
    init?(json: Any) {
        if let jsonDict = json as? [String: Any]{
            //print(jsonDict)
            if let score = jsonDict["score"] as? String,
            let username = jsonDict["username"] as? String,
            let score1 = Double(score),
            let username1 = Int(username)
            {
                //print(jsonDict)
                self.score = Double(round(score1*1000)/1000)
                self.username = username1
            }
            else{
                return nil
            }
        }
     else {
            return nil;
        }
    }
}
    


class LeaderboardViewModel {
    
    var scores: [LeaderboardRow]?
    
    let quizId: Int
    
    init(quizId: Int) {
        self.quizId = quizId
    }
    
    func fetchLeaderboard(completion: @escaping (() -> Void)) {
        LeaderboardService().fetchLeaderboard(quizId: quizId, completion: {
            [weak self] (scores) in
             self?.scores = scores
            completion()
        })
    }
    
    
    
    //data za celiju na odredenom indexu
    func score(atIndex index: Int) -> LeaderboardRow? {
        guard let score = scores?[index] else {
            return nil
        }
       return score
    }
        
    func numberOfScores() -> Int {
            return scores?.count ?? 0
    }
    
}
