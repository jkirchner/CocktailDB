//
//  Drink.swift
//  CocktailDB
//
//  Created by Jason Kirchner on 9/13/21.
//

import Foundation

struct Ingredient: CustomStringConvertible, Hashable {

    let name: String
    let measurement: String?

    var description: String {
        var description = name

        if let measurement = measurement {
            description = "\(measurement) \(name)"
        }

        return description
    }

}

struct Drink: Decodable, CustomStringConvertible {

    let id: String
    let name: String
    let category: String
    let instructions: String
    let ingredients: [Ingredient]
    let glassNeeded: String
    let image: URL?
    let thumbnail: URL

    var description: String {
        var description = name + "\n" + instructions

        for ingredient in ingredients {
            description = description + "\n" + ingredient.description
        }

        return description + "\n"
    }

    private enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case instructions = "strInstructions"
        case glassNeeded = "strGlass"
        case image = "strImageSource"
        case thumbnail = "strDrinkThumb"
    }

    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Not using integer key dictionary, just stubbed to make compiler happy
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(String.self, forKey: .category)
        instructions = try container.decode(String.self, forKey: .instructions)
        glassNeeded = try container.decode(String.self, forKey: .glassNeeded)
        image = try? container.decode(URL.self, forKey: .image)
        thumbnail = try container.decode(URL.self, forKey: .thumbnail)

        var ingredients = [Ingredient]()

        let ingredientContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        let ingredientKeyString = "strIngredient"
        let measureKeyString = "strMeasure"
        let maxNumberOfIngredients = 15

        for i in 1...maxNumberOfIngredients {
            let ingredient = ingredientKeyString + "\(i)"
            let measure = measureKeyString + "\(i)"

            if let ingredientKey = DynamicCodingKeys(stringValue: ingredient),
               let measureKey = DynamicCodingKeys(stringValue: measure),
               let ingredient = try? ingredientContainer.decode(String.self, forKey: ingredientKey) {
                let measurement = try? ingredientContainer.decode(String.self, forKey: measureKey)

                ingredients.append(Ingredient(name: ingredient, measurement: measurement))
            }
        }

        self.ingredients = ingredients
    }
}
