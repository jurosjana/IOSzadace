//
//  Leaderboard.swift
//  IOSQuizz
//
//  Created by Jana on 15/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation
import UIKit

class Leaderboard : UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func closeLeaderboard(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var viewModel: LeaderboardViewModel!
    var refreshControl: UIRefreshControl!
    var tableFooterView: QuizTableViewFooterView!
        
    let cellReuseIdentifier = "cellReuseIdentifier"



    convenience init(viewModel: LeaderboardViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = viewModel{
            setupTableView()
            bindViewModel()
        }
        
        
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

           tableView.register(UINib(nibName: "LeaderboardTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
           
          // tableFooterView = QuizTableViewFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
           //tableView.tableFooterView = tableFooterView
           //tableFooterView.delegate = self
       }
    
    func bindViewModel() {
        viewModel.fetchLeaderboard {
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

extension Leaderboard : UITableViewDelegate {
    
    //visina celija
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
   
    //header sekcije
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = LeaderboardHeader()
        view.backgroundColor = #colorLiteral(red: 0.8224276638, green: 0.9578640546, blue: 0.8818163687, alpha: 1)
        return view
    }
    
    
    
    //visina header viewa sekcije
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
  
    //tap na celiju
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let viewModel = viewModel.viewModel(atIndex: indexPath) {
            let kvizEkran = KvizEkran(viewModel: viewModel)
            navigationController?.pushViewController(kvizEkran, animated: true)
        }
    }
 */
}

extension Leaderboard : UITableViewDataSource {
    
    //UITableViewCell koji ce prikazati za odredeni indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! LeaderboardTableViewCell
        
        if let row = viewModel.score(atIndex: indexPath.row) {
            cell.setup(withScore: row, index: indexPath.row)
        }
        return cell
    }
   

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //broj redaka
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.scores?.count ?? 0;
    }
}




    
  
   





