//
//  QuestionView1.swift
//  IOSQuizz
//
//  Created by Jana on 01/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit
import PureLayout


protocol QuestionViewDelegate: class {
    func questionAnswered(correct: Bool)
}


class QuestionView1: UIView {
    
    weak var delegate: QuestionViewDelegate?
    
    var tocanOdgovor: Int = 0
    
    var height: Double = 400
    
    
    var pitanje: UILabel!{
        didSet{
            pitanje.numberOfLines = 0
        }
    }
    var odgovor1: UIButton!
    var odgovor2: UIButton!
    var odgovor3: UIButton!
    var odgovor4: UIButton!
    
   
    

    // Ovaj init se poziva kada se CustomView inicijalizira iz .xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
            
           super.init(frame: frame)
           
           backgroundColor = #colorLiteral(red: 0.6785272956, green: 0.918264091, blue: 0.932025373, alpha: 1)
           pitanje = UILabel()
            odgovor1 = UIButton(type: .custom)
           odgovor2 = UIButton()
           odgovor3 = UIButton()
           odgovor4 = UIButton()
        
        odgovor1.tag = 1
        odgovor2.tag = 2
        odgovor3.tag = 3
        odgovor4.tag = 4
        
       
        odgovor1.addTarget(self, action: #selector(oboji), for: UIControl.Event.touchUpInside)
        odgovor2.addTarget(self, action: #selector(oboji), for: UIControl.Event.touchUpInside)
        odgovor3.addTarget(self, action: #selector(oboji), for: UIControl.Event.touchUpInside)
        odgovor4.addTarget(self, action: #selector(oboji), for: UIControl.Event.touchUpInside)
        
        odgovor1.addTarget(self, action: #selector(questionButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        odgovor2.addTarget(self, action: #selector(questionButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        odgovor3.addTarget(self, action: #selector(questionButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        odgovor4.addTarget(self, action: #selector(questionButtonTapped(_:)), for: UIControl.Event.touchUpInside)
           
           self.addSubview(pitanje)
           self.addSubview(odgovor1)
           self.addSubview(odgovor2)
           self.addSubview(odgovor3)
           self.addSubview(odgovor4)
           
       
          
    
          }
       
    
    
    convenience init(frame: CGRect, question: Question, height: Double) {
        
        self.init(frame: frame)
        
         pitanje.text = question.question
         odgovor1.setTitle(question.answers[0], for: .normal)
         odgovor2.setTitle(question.answers[1], for: .normal)
         odgovor3.setTitle(question.answers[2], for: .normal)
         odgovor4.setTitle(question.answers[3], for: .normal)
         tocanOdgovor = question.correctAnswer
         pitanje.sizeToFit()
         pitanje.numberOfLines = 0
         
        
        
          pitanje.autoSetDimension(.width, toSize: self.frame.size.width - 50)
          pitanje.textAlignment = .center
          pitanje.autoAlignAxis(.vertical, toSameAxisOf: self)
          pitanje.autoPinEdge(.top, to: .top, of: self, withOffset:CGFloat(height*0.05))
          odgovor1.autoPinEdge(.top, to: .bottom, of: pitanje, withOffset: CGFloat(height*0.10))
          odgovor2.autoPinEdge(.top, to: .bottom, of: odgovor1, withOffset: CGFloat(height*0.05))
          odgovor3.autoPinEdge(.top, to: .bottom, of: odgovor2, withOffset: CGFloat(height*0.05))
          odgovor4.autoPinEdge(.top, to: .bottom, of: odgovor3, withOffset: CGFloat(height*0.05))
        
        
 
          odgovor1.autoAlignAxis(.vertical, toSameAxisOf: self)
          odgovor2.autoAlignAxis(.vertical, toSameAxisOf: self)
          odgovor3.autoAlignAxis(.vertical, toSameAxisOf: self)
          odgovor4.autoAlignAxis(.vertical, toSameAxisOf: self)
        
        
        
    }
      
    @objc func questionButtonTapped(_ sender: UIButton) {
        var correct = false
        if(sender.tag == tocanOdgovor){
            correct = true
        }
        delegate?.questionAnswered(correct: correct)
    }
   
       
    func obojigumb(button: UIButton, br: Int) {
        if(tocanOdgovor==br){
            button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else  {
            button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
    @objc func oboji(sender:UIButton)
    {
        
        switch sender.tag
        {
            case 1:
                obojigumb(button: self.odgovor1, br: 0);                break
            case 2:
                obojigumb(button: self.odgovor2, br: 1);                break
            case 3:
                obojigumb(button: self.odgovor3, br: 2);                break
            case 4:
                obojigumb(button: self.odgovor4, br: 3);                break
            
            default: break
                

        }
    }
}

    
    

    
    
  
