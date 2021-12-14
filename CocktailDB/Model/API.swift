//
//  API.swift
//  CocktailDB
//
//  Created by Jason Kirchner on 12/12/21.
//

import Foundation
import Combine

struct API {

    // The cocktail API is defined at https://www.thecocktaildb.com/api.php
    private static let baseURL = "https://www.thecocktaildb.com"
    private static let apiVersion = "/api/json/v1/1/"

    static func search(_ searchString: String) -> AnyPublisher<[SearchResult], Error> {
        var urlComps = URLComponents(string: baseURL)!
        urlComps.path = apiVersion + "search.php"

        let items = [
            URLQueryItem(name: "s", value: searchString)
            ]
        urlComps.queryItems = items

        return URLSession.shared.dataTaskPublisher(for: urlComps.url!)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                          throw URLError(.badServerResponse)
                      }
                return element.data
            }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .eraseToAnyPublisher()
    }

    static func fetch(_ drinkId: String) -> AnyPublisher<Drink, Error> {
        var urlComps = URLComponents(string: baseURL)!
        urlComps.path = apiVersion + "lookup.php"

        let items = [
            URLQueryItem(name: "i", value: drinkId)
            ]
        urlComps.queryItems = items

        return URLSession.shared.dataTaskPublisher(for: urlComps.url!)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                          throw URLError(.badServerResponse)
                      }
                return element.data
            }
            .decode(type: DetailsResponse.self, decoder: JSONDecoder())
            .map { $0.drink }
            .eraseToAnyPublisher()
    }
}
