//
//  ProductTableViewCell.swift
//  TableViewProject
//
//  Created by Sultan Daurenbek on 4/12/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titlemovie: UILabel!
    
    @IBOutlet weak var movieyear: UILabel!
    
    @IBOutlet weak var movieplot: UILabel!
    var detail: Detail! {
          didSet {
              updateUI()
          }
      }
      
      // MARK: - Methods
      func updateUI() {
        self.titlemovie.text = detail.title
        self.movieyear.text = detail.year
        self.movieplot.text = detail.posterURL
          
          }
      }
    

