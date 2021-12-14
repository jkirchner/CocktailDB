//
//  SearchModel.swift
//  CocktailDB
//
//  Created by Jason Kirchner on 12/12/21.
//

import Foundation
import Combine

class SearchModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    @Published var searchString = ""
    @Published var results = [SearchResult]()
    @Published var searching = false

    init() {
        bindToSearch()
    }

    private func search(_ searchString: String) {
        searching = true
        API.search(searchString)
            .receive(on: DispatchQueue.main)
            .sink { result in
                self.searching = false
            } receiveValue: { results in
                self.results = results
            }
            .store(in: &cancellables)
    }

    private func bindToSearch() {
        $searchString
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .compactMap {
                if $0.count > 0 {
                    return $0
                }
                return nil
            }
            .sink { searchString in
                self.search(searchString)
            }
            .store(in: &cancellables)

    }
}
