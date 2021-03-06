//
//  QuizViewModel.swift
//  IOSQuizz
//
//  Created by Jana on 30/05/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import Reachability


struct QuizCellModel{
    let imageUrl: URL?
    let title: String
    let description: String
    let level: String
    
    init(quiz: Quiz){
        self.title = quiz.title ?? "title"
        self.description = quiz.quizDescription ?? ""
        self.imageUrl = URL(string: quiz.imageUrl ?? "")
        switch quiz.level {
            case 1:
                self.level = "*"
            case 2:
                self.level = "**"
            case 3:
                self.level = "***"
            case 4:
                self.level = "****"
            case 5:
                self.level = "*****"
            default:
                self.level = "*"
        }
    }
}

class QuizViewModel{
    var quizzes: [Quiz]?
    var quizBycategories: [QuizCategory : [Quiz]] = Dictionary<QuizCategory, Array<Quiz>>()
    var categories: [QuizCategory?] = []
    
    

    
    func fetchQuizzes(completion: @escaping (() -> Void)) {
        //startHost(at: 0)
        
        let reachability = try! Reachability()

        if(reachability.connection != .unavailable){
            //sa servera
            QuizService().fetchQuizzes { [weak self] (quizzes) in
            self?.quizzes = DataController.shared.fetchQuizzes()
            if let quizzes = quizzes {
                print("sa servera")
                self?.namjestiListe(quizzes: quizzes)
            }
            completion()
            }
        }
        
        else{
            print("Not reachable")
            print("iz baze")
            //iz baze
            self.quizzes = DataController.shared.fetchQuizzes()
            if let quizzes = self.quizzes {
                self.namjestiListe(quizzes: quizzes)
            }
        }
    }
    
    func fetchQuizzesWithSearch (string:String, completion: @escaping (() -> Void)) {

            
            print("iz baze")
            //iz baze
            self.quizzes = DataController.shared.fetchQuizzesWithSearch(string: string)
            if let quizzes = self.quizzes {
                self.namjestiListe(quizzes: quizzes)
            }
        
    }

    
    
    func namjestiListe(quizzes: [Quiz]){
        quizzes.map {quiz in
            if let _ = self.quizBycategories[quiz.category] {
                self.quizBycategories[quiz.category]?.append(quiz)
            } else {
                var newArray = [Quiz]()
                newArray.append(quiz)
                self.categories.append(quiz.category)
                self.quizBycategories[quiz.category] = newArray
            }
        }
    }
    
    
    
    //viewModel za KvizEkran - kad odaberemo kviz napuni se
    func viewModel(atIndex index: IndexPath) -> SingleQuizViewModel? {
        if let category = categories[index.section],
        let quiz = quizBycategories[category]?[index.row] {
            return SingleQuizViewModel(quiz: quiz)
        } else {
            return nil
        }
    }
    
    
    //data za celiju na odredenom indexPath
    func quiz(atIndex index: IndexPath) -> QuizCellModel? {
        if let category = categories[index.section],
        let quiz = quizBycategories[category]?[index.row] {
            return QuizCellModel(quiz: quiz)
        } else {
            return nil
        }
    }
        
    func numberOfQuizzes() -> Int {
            return quizzes?.count ?? 0
    }

}
