//
//  InitialViewController.swift
//  IOSQuizz
//


import UIKit
class InitialViewController: UIViewController{
    
    @IBOutlet weak var questionViewContainer: UIView!{
        didSet{
            questionViewContainer.isHidden = true
        }
    }
    @IBOutlet weak var Slika: UIImageView!
    @IBOutlet weak var FunFactLabela: UILabel!{
        didSet{
            FunFactLabela.numberOfLines = 0
            FunFactLabela.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
    }
    @IBOutlet weak var NaslovLabela: UILabel!{
        didSet {
            NaslovLabela.isHidden = true
        }
    }

    @IBOutlet weak var DohvatiButton: UIButton!
    
    @IBOutlet weak var skrivenaLabela: UILabel!{
        didSet {
            skrivenaLabela.isHidden = true
        }
    }
    
    
    @IBAction func Dohvati(_ sender: UIButton) {
        //let quizzes : [OneQuiz]
        fetchImageandTitle()
    
    }
    

    
    

    
    func fetchImageandTitle(){
        //ovdje cu prvo ucitati sve kvizeve u listu
        fetchQuizzes { (quizzes) in
            DispatchQueue.main.async {
                var count : Int = 0
                //ako je dohvacanje uspjelo
                if let quizzes = quizzes {
                     for i in quizzes{
                        let NBAquestions = i.questions.filter{ (value) -> Bool in
                            return value.question.contains("NBA")}
                        count += NBAquestions.count
                        }
                     self.FunFactLabela.text = "Fun Fact: Postoji \(count) pitanja koja sadrže riječ NBA u sebi."
                    
                    //odabrat cu sliku i title iz prvog kviza
                    //prvo dohvati sliku
                    fetchImage (urlString: quizzes[0].imageUrl){ (image) in
                        print("setting image")
                        DispatchQueue.main.async {
                            self.Slika.image = image
                        }
                        print("image set")
                    }
                    //namjesti naslov, sliku i dodaj questionview od prvog pitanja
                    self.Slika.backgroundColor = quizzes[0].category.color
                    self.NaslovLabela.text = quizzes[0].title
                    self.NaslovLabela.backgroundColor = quizzes[0].category.color
                    self.NaslovLabela.isHidden = false
                    //stavljam prvo pitanje iz prvog kviza u QuestionView
                    self.addQuestionView(question1: quizzes[0].questions[0])
                 
                //ako dohvacanje nije uspjelo
                } else {
                 //print("ne radi")
                self.skrivenaLabela.isHidden = false
             }
               
            }
        }
    }
        
    
    func addQuestionView(question1: Question) {
            //stvaram question view i dodajem i questionViewContainer
            //postavljam pitanje i odgovore
            if let questionView2 = Bundle.main.loadNibNamed("QuestionView", owner: nil, options: [:])?.first as? QuestionView { questionViewContainer.addSubview(questionView2)
                
                //da odgovara velicinom roditelju
                questionView2.setConstraints(withRelationshipTo: questionViewContainer)
                
                //namjesti tekst u labeli i gumbima pitanja i odg
                questionView2.pitanje.text = question1.question
                questionView2.odgovor1.setTitle(question1.answers[0], for: .normal)
                questionView2.pitanje.lineBreakMode = NSLineBreakMode.byWordWrapping
                questionView2.odgovor2.setTitle(question1.answers[1], for: .normal)
                questionView2.odgovor3.setTitle(question1.answers[2], for: .normal)
                questionView2.odgovor4.setTitle(question1.answers[3], for: .normal)
                questionView2.tocanOdgovor = question1.correctAnswer
                print(question1.correctAnswer)
                
                self.questionViewContainer.isHidden = false
            }
        }
    }
        
    
 
