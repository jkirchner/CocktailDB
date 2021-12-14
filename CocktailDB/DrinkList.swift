//
//  DrinkList.swift
//  CocktailDB
//
//  Created by Jason Kirchner on 12/12/21.
//

import SwiftUI

struct DrinkList: View {

    @StateObject private var searchModel = SearchModel()

    var body: some View {
        ScrollView {
            SearchBar(searchString: $searchModel.searchString, searching: $searchModel.searching)

            LazyVStack(spacing: 20) {
                ForEach(searchModel.results, id: \.self) { result in
                    NavigationLink {
                        DrinkDetailView(result: result)
                    } label: {
                        resultView(for: result)
                    }
                    .buttonStyle(.plain)

                }
            }
            Spacer()
        }
        .hideKeyboardOnTap()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .navigationBarTitle("Search")
    }

    @ViewBuilder
    private func resultView(for result: SearchResult) -> some View {
        HStack(spacing: 10) {
            VStack {
                AsyncImage(url: result.thumbnail) {
                    Image(systemName: "drop.circle.fill")
                        .resizable()
                        .foregroundColor(Color.blue)
                }
                .clipShape(Circle())
                .frame(width: 60, height: 60, alignment: .center)

                Spacer()
            }

            VStack {
                Text(result.name)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(result.category)
                    .foregroundColor(Color.gray)
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(result.instructions)
                    .font(.body)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DrinkList_Previews: PreviewProvider {
    static var previews: some View {
        DrinkList()
            .previewDevice("iPhone 8")
    }
}
