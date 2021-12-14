//
//  DrinkDetailView.swift
//  CocktailDB
//
//  Created by Jason Kirchner on 12/12/21.
//

import SwiftUI

struct DrinkDetailView: View {

    @StateObject private var model: DrinkDetailModel

    init(result: SearchResult) {
        _model = StateObject(wrappedValue: DrinkDetailModel(result))
    }

    var body: some View {
        ScrollView {
            if let drink = model.drink {
                detail(for: drink)
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2.0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }

    @ViewBuilder
    private func detail(for drink: Drink) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(drink.name)
                .font(.largeTitle)

            AsyncImage(url: drink.image ?? drink.thumbnail) {
                Image(systemName: "drop.circle.fill")
                    .resizable()
                    .foregroundColor(Color.blue)
            }
            .aspectRatio(1.75, contentMode: .fill)
            .frame(maxWidth: .infinity, alignment: .center)
            .clipped()
            .cornerRadius(4)

            VStack(alignment: .leading, spacing: 10) {
                Text("INSTRUCTIONS")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)

                Text(drink.instructions)
                    .font(.body)
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("\(drink.ingredients.count) ingredients".uppercased())
                    .font(.callout)
                    .foregroundColor(Color.gray)

                ForEach(drink.ingredients, id: \.self) { ingredient in
                    Text(ingredient.description)
                }
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Glass Needed".uppercased())
                    .font(.callout)
                    .foregroundColor(Color.gray)

                Text(drink.glassNeeded)
                    .font(.body)
            }

            Divider()
            Button(action: actionSheet) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }

    func actionSheet() {
        guard let description = model.drink?.description, let id = model.drink?.id else { return }
        let link = URL(string: "https://www.thecocktaildb.com/drink/\(id)")
        let activityVC = UIActivityViewController(activityItems: [description, link], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}
