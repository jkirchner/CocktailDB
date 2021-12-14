//
//  DetailsResponse.swift
//  CocktailDB
//
//  Created by Jason Kirchner on 9/15/21.
//

import Foundation

struct DetailsResponse: Decodable {

    let drink: Drink

    private enum CodingKeys: String, CodingKey {
        case drinks
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let drinks = try container.decode([Drink].self, forKey: .drinks)

        guard let foundDrink = drinks.first else {
            throw DecodingError.valueNotFound(Drink.self, DecodingError.Context(codingPath: [CodingKeys.drinks], debugDescription: "Drink not found in response data"))
        }

        drink = foundDrink
    }
}
