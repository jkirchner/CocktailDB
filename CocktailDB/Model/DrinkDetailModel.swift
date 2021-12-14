//
//  DrinkDetailModel.swift
//  CocktailDB
//
//  Created by Jason Kirchner on 12/12/21.
//

import Foundation
import Combine

class DrinkDetailModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    @Published var drink: Drink?

    init(_ result: SearchResult) {
        fetchDrink(result.id)
    }

    private func fetchDrink(_ drinkId: String) {
        API.fetch(drinkId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                print(result)
            }, receiveValue: { drink in
                self.drink = drink
            })
            .store(in: &cancellables)
    }

}
