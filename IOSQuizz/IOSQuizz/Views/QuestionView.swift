//
//  QuestionView.swift
//  IOSQuizz
//


import UIKit
class QuestionView: UIView {

    
    var tocanOdgovor: Int = 0
    
    
    @IBOutlet weak var pitanje: UILabel!{
        didSet{
            pitanje.numberOfLines = 0
        }
    }
    @IBOutlet weak var odgovor1: UIButton!
    @IBOutlet weak var odgovor2: UIButton!
    @IBOutlet weak var odgovor3: UIButton!
    @IBOutlet weak var odgovor4: UIButton!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    @IBAction func oboji1(_ sender: Any) {
        if tocanOdgovor == 0{
            self.odgovor1.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else{
            self.odgovor1.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        print(tocanOdgovor)
    }
    
    
    @IBAction func oboji2(_ sender: Any) {
        if tocanOdgovor == 1{
            self.odgovor2.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else{
            self.odgovor2.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
    @IBAction func oboji3(_ sender: Any) {
        if tocanOdgovor == 2{
            self.odgovor3.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else{
            self.odgovor3.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
    
    @IBAction func oboji4(_ sender: Any) {
        if tocanOdgovor == 3{
            self.odgovor4.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else{
            self.odgovor4.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
    // Ovaj init se poziva kada se CustomView inicijalizira iz .xib datoteke
    
    
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setConstraints(withRelationshipTo view: UIView){
        self.translatesAutoresizingMaskIntoConstraints = false

        // Replace with your own custom constraints
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    

}

 
