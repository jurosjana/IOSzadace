//
//  KvizEkran.swift
//  IOSQuizz
//
//  Created by Jana on 06/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit

var otvoreniKviz1: Int16?
var otvoreniKviz2: Int16?

class KvizEkran : UIViewController {
    
    var StartQuizButton: UIButton!
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var ScrollView: UIScrollView!
    var viewModel: SingleQuizViewModel!
    var HighscoreButton: UIButton!
    
    var answered: Int = 0
    var correct: Int = 0
    var start: Date?
    var kvizPokrenut: Int = 0
    
    convenience init(viewModel: SingleQuizViewModel) {
        self.init()
        self.viewModel = viewModel
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if(self.isMovingFromParent == true && kvizPokrenut == 1){
            //korisnik je izasao iz kviza pa oznacavam da nije vise otvoren
            if(otvoreniKviz1 != nil && otvoreniKviz1 == self.viewModel.quiz?.id) {
                print("zatvaram 1:", self.viewModel.quiz?.id as Any)
                otvoreniKviz1 = nil
            }
            if(otvoreniKviz2 != nil && otvoreniKviz2 == self.viewModel.quiz?.id) {
                print("zatvaram 2:", self.viewModel.quiz?.id as Any)
                otvoreniKviz2 = nil
            }
        }
    }
   
        
    
    override func viewDidLoad() {
        LeaderboardService().fetchLeaderboard(quizId: Int(viewModel.quiz!.id), completion: {_ in
            print("completion")
        })
        super.viewDidLoad()
        self.view.backgroundColor = viewModel.quiz?.category.color
        
        StartQuizButton = UIButton()
        imageView = UIImageView()
        titleLabel = UILabel()
        ScrollView = UIScrollView()
        HighscoreButton = UIButton()
        self.view.addSubview(StartQuizButton)
        self.view.addSubview(imageView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(ScrollView)
        self.view.addSubview(HighscoreButton)
        bindViewModel()
        
    }
    
    
    func bindViewModel() {
        
        let guide = view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
        titleLabel.autoPinEdge(toSuperviewMargin: .top, withInset: 0.04*height)
        imageView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 0.04*height)
        StartQuizButton.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 0.04*height)
        StartQuizButton.autoPinEdge(.left, to: .left, of: view, withOffset: 50)
        HighscoreButton.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 0.04*height)
        HighscoreButton.autoPinEdge(.right, to: .right, of: view, withOffset: -50)
        ScrollView.autoPinEdge(.top, to: .bottom, of: StartQuizButton, withOffset: 0.04*height)
        ScrollView.autoPinEdge(.leading, to: .leading, of: self.view)
             
        titleLabel.autoSetDimension(.height, toSize: 0.04*height)
        imageView.autoSetDimension(.height, toSize: 0.2*height)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
      
        ScrollView.autoSetDimension(.height, toSize: height/2)
        ScrollView.autoSetDimension(.width, toSize: self.view.frame.size.width)
        ScrollView.frame.size.height = height/2
        ScrollView.frame.size.width = view.frame.size.width
        //print("scroll height: ",ScrollView.frame.size.height)
        
        titleLabel.autoAlignAxis(.vertical, toSameAxisOf: self.view)
        imageView.autoAlignAxis(.vertical, toSameAxisOf: self.view)
        //StartQuizButton.autoAlignAxis(.vertical, toSameAxisOf: self.view)
     
        
        titleLabel.text = viewModel.quizTitle
        StartQuizButton.setTitle("Start quiz", for: .normal)
        StartQuizButton.addTarget(self, action: #selector(startQuiz), for: UIControl.Event.touchUpInside)
        
        HighscoreButton.setTitle("View highscore", for: .normal)
        HighscoreButton.addTarget(self, action: #selector(viewHighscore), for: UIControl.Event.touchUpInside)
        
        imageView.kf.setImage(with: viewModel.imageUrl)
        ScrollView.isScrollEnabled = false
        ScrollView.isHidden = true
        ScrollView.backgroundColor = #colorLiteral(red: 0.9578640546, green: 0.9080962065, blue: 0.9040285305, alpha: 1)
        
        let width = Int(UIScreen.main.bounds.width)
        ScrollView.contentSize = CGSize(width: CGFloat(viewModel.questions.count) * CGFloat(width), height: ScrollView.bounds.size.height)
        var i = 0
        for question in viewModel.questions {
        let questionView = QuestionView1 (frame: CGRect(x:0+i*width, y:0, width: width, height: Int(ScrollView.frame.size.height)), question: question, height: Double(height/2))
            questionView.delegate = self
            ScrollView.addSubview(questionView)
            i+=1;
        }
        
        
    }
    
    @objc func startQuiz(sender: UIButton){
        //ako je taj kviz vec otvoren, ne daj da ga ponovno otvori
        if (otvoreniKviz1 != nil && otvoreniKviz1 == self.viewModel.quiz?.id || otvoreniKviz2 != nil && otvoreniKviz2 == self.viewModel.quiz?.id) {
            let alert = UIAlertController(title: "Error", message: "Quiz is already running in other tab", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
             NSLog("The \"OK\" alert occured.")
             }))
              
              DispatchQueue.main.async {
               self.present(alert, animated: true, completion: nil)
              }
            return
        }
    
        //inace otvori kviz i oznaci da je otvoren
        kvizPokrenut = 1
        if let id = self.viewModel.quiz?.id{
            if (otvoreniKviz1 == nil){
                print("otvoren 1: ", id)
                otvoreniKviz1 = id
            }
            else{
                print("otvoren 2: ", id)
                otvoreniKviz2 = id
            }
        }
        ScrollView.isHidden = false
        start = Date.init()
    }
    
    @objc func viewHighscore(sender: UIButton){
        let viewModel1 = LeaderboardViewModel(quizId: Int(viewModel.quiz!.id))
        let leaderboard = Leaderboard(viewModel: viewModel1)
        self.present(leaderboard, animated: true)
       }
    
 
}


extension KvizEkran : QuestionViewDelegate{
    
    func questionAnswered(correct: Bool) {
        if (correct) {self.correct += 1}
        answered += 1
        //print("answered: ",answered)
        //ako je odg na zadnje pitanje
        if (answered == viewModel.questions.count){
            sendAnswers()
        }
        let width = Int(UIScreen.main.bounds.width)
        ScrollView.setContentOffset(CGPoint.init(x: answered*width, y: 0), animated: true)
    }
    
    func sendAnswers(){
        
        
        
       let time = Date.init()
       let interval = time.timeIntervalSince(start!)
       let userDefaults = UserDefaults.standard
       let id = userDefaults.string(forKey: "id")!
      // let token = userDefaults.string(forKey: "token")
       let parameters = ["quiz_id": viewModel.quiz!.id, "user_id": Int(id)!, "time": interval, "no_of_correct": self.correct] as [String : Any]

        QuizService().sendAnswers(parameters: parameters, completion: { response in
            if let response = response {
                if (response != ServerResponse.OK){
                let alert = UIAlertController(title: "Failed", message: response.message, preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                  NSLog("The \"OK\" alert occured.")
                  }))
                alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {_ in self.sendAnswers()}))
                   
                   DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                   }
              } else {
                   DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                   }
               
              }
                //nema odgovora
            } else {
                let alert = UIAlertController(title: "Failed", message: "No response.", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                  NSLog("The \"OK\" alert occured.")
                  }))
                alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {_ in self.sendAnswers()}))
                   
                   DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                   }
            }
        })
       
    }
}
