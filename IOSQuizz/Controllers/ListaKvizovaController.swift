//
//  ListaKvizovaController.swift
//  IOSQuizz
//
//  Created by Jana on 29/05/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit



class ListaKvizovaController:UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var tableFooterView: QuizTableViewFooterView!
        
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    var viewModel: QuizViewModel!
    
    convenience init(viewModel: QuizViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //skriva navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupTableView() {
       
        tableView.backgroundColor = #colorLiteral(red: 0.9578640546, green: 0.9080962065, blue: 0.9040285305, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ListaKvizovaController.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl

        tableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        tableFooterView = QuizTableViewFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        tableView.tableFooterView = tableFooterView
        tableFooterView.delegate = self
    }
    
    
    func bindViewModel() {
        viewModel.fetchQuizzes {
            self.refresh()
        }
    }
    
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
        
}


extension ListaKvizovaController: UITableViewDelegate {
    
    //visina celija
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
   
    //header sekcije
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = QuizTableSectionHeader()
        guard let category = self.viewModel.categories[section] else {
            return view
        }
        view.titleLabel.text = category.name
        view.backgroundColor = category.color
        return view
    }
    
    
    
    //visina header viewa sekcije
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
  
    //tap na celiju
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let viewModel1 = viewModel.viewModel(atIndex: indexPath) {

            let kvizEkran = KvizEkran(viewModel: viewModel1)
            navigationController?.pushViewController(kvizEkran, animated: true)
        }
    }
}

extension ListaKvizovaController: UITableViewDataSource {
    
    //UITableViewCell koji ce prikazati za odredeni indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! QuizTableViewCell
        
        if let quiz = viewModel.quiz(atIndex: indexPath) {
            cell.setup(withQuiz: quiz)
        }
        return cell
    }
   

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.quizBycategories.count
    }
    
    //broj redaka
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let category = self.viewModel.categories[section],
            let list = viewModel.quizBycategories[category]
             else {
                return 0
        }
        
        return list.count;
    }
}


extension ListaKvizovaController: TableViewFooterViewDelegate {
    func logOut() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "token")
        userDefaults.removeObject(forKey: "user_id")
        userDefaults.removeObject(forKey: "username")
        DispatchQueue.main.async {
            /*self.navigationController?.pushViewController(LoginViewController(), animated: true)*/
            UIApplication.shared.windows.first!.rootViewController = LoginViewController()
        }
    }
}



