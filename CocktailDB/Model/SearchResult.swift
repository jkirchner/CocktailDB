//
//  SearchResult.swift
//  CocktailDB
//
//  Created by Jason Kirchner on 9/13/21.
//

import Foundation

struct SearchResult: Decodable, Hashable {

    let id: String
    let name: String
    let category: String
    let instructions: String
    let thumbnail: URL

    private enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case instructions = "strInstructions"
        case thumbnail = "strDrinkThumb"
    }

}
