//
//  DetailViewController.swift
//  TableViewProject
//
//  Created by Sultan Daurenbek on 4/12/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var details: [Detail] = []

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadDetails()

        

        // Do any additional setup after loading the view.
    }
    @objc func downloadDetails() {
           DetailMovieService.shared.downloadMovies { response in
               self.details = response.details
               self.tableView.refreshControl?.endRefreshing()
               self.tableView.reloadData()
           }
       }
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
 
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! ProductTableViewCell
        cell.detail = self.details[0]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 396
    }
}

