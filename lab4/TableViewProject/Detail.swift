//
//  Detail.swift
//  TableViewProject
//
//  Created by Sultan Daurenbek on 4/12/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation
class Detail: Codable {
    var title: String
    var type: String
    var year: String
    var id: String
    var posterURL: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case type = "Type"
        case year = "Year"
        case id = "imdbID"
        case posterURL = "Poster"
    }
}
