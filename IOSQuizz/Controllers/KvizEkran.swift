//
//  KvizEkran.swift
//  IOSQuizz
//
//  Created by Jana on 06/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit


class KvizEkran : UIViewController {
    
    var StartQuizButton: UIButton!
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var ScrollView: UIScrollView!
    var viewModel: SingleQuizViewModel!
    
    var answered: Int = 0
    var correct: Int = 0
    var start: Date?
    
    convenience init(viewModel: SingleQuizViewModel) {
        self.init()
        self.viewModel = viewModel
        
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=viewModel.quiz?.category.color
        StartQuizButton = UIButton()
        imageView = UIImageView()
        titleLabel = UILabel()
        ScrollView = UIScrollView()
        self.view.addSubview(StartQuizButton)
        self.view.addSubview(imageView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(ScrollView)
        bindViewModel()
        
    }
    
    
    func bindViewModel() {
        
        let guide = view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
        titleLabel.autoPinEdge(toSuperviewMargin: .top, withInset: 0.04*height)
        imageView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 0.04*height)
        StartQuizButton.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 0.04*height)
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
        StartQuizButton.autoAlignAxis(.vertical, toSameAxisOf: self.view)
     
        
        titleLabel.text = viewModel.quizTitle
        StartQuizButton.setTitle("Start quiz", for: .normal)
        StartQuizButton.addTarget(self, action: #selector(startQuiz), for: UIControl.Event.touchUpInside)
        
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
        ScrollView.isHidden = false
        start = Date.init()
    }
 
}


extension KvizEkran : QuestionViewDelegate{
    
    func questionAnswered(correct: Bool) {
        if (correct) {self.correct += 1}
        answered += 1
        print("answered: ",answered)
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
       let token = userDefaults.string(forKey: "token")
       let parameters = ["quiz_id": viewModel.quiz!.id, "user_id": Int(id)!, "time": interval, "no_of_correct": self.correct] as [String : Any]

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
       let task = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] data, response, error in

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
                    //print(response?.message as Any)
                   if (response != ServerResponse.OK){
                       let alert = UIAlertController(title: "Failed", message: response?.message, preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                       NSLog("The \"OK\" alert occured.")
                       }))
                        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {_ in self?.sendAnswers()}))
                        DispatchQueue.main.async {
                        self?.present(alert, animated: true, completion: nil)
                        }
                   } else {
                        DispatchQueue.main.async {
                            self?.navigationController?.popViewController(animated: true)
                        }
                   }
               }
           } catch let error {
               print(error.localizedDescription)
           }
       })
       task.resume()
    }
}
