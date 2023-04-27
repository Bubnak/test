//
//  Model types.swift
//  TopQuestion
//
//  Created by Matteo Manferdini on 10/09/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import Foundation
import UIKit

// MARK: - User
struct Movie {
    let imdbID: String?
    let Year: String?
    let Title: String?
    let MovieType: String?
    let Poster: String?
}



extension Movie: Decodable {
	enum CodingKeys: String, CodingKey {
		case imdbID,Year, Title, Poster
		case MovieType = "Type"
	}
}

// MARK: - Question
struct Question: Identifiable {
    let id: Int
    let Search :[Movie]
        let totalResults: String
         let Response: String
}

extension Question: Decodable {
	enum CodingKeys: String, CodingKey {
		case  totalResults, Response, id,Search
	}
}

