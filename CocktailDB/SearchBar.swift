//
//  SearchBar.swift
//  CocktailDB
//
//  Created by Jason Kirchner on 12/12/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchString: String
    @Binding var searching: Bool

    var body: some View {
        TextField("Search cocktail", text: $searchString)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)

                    Spacer()

                    if searching {
                        ProgressView()
                            .padding(.trailing, 8)
                    }
                })
    }
}
