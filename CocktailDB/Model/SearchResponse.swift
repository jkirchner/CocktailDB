//
//  SearchResponse.swift
//  CocktailDB
//
//  Created by Jason Kirchner on 9/15/21.
//

import Foundation

struct SearchResponse: Decodable {

    let results: [SearchResult]

    private enum CodingKeys: String, CodingKey {
        case results = "drinks"
    }
}
