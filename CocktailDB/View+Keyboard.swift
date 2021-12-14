//
//  View+Keyboard.swift
//  CocktailDB
//
//  Created by Jason Kirchner on 12/12/21.
//

import SwiftUI

extension View {

    func hideKeyboardOnTap() -> some View {
        modifier(HideKeyboardOnTapModifier())
    }

}

struct HideKeyboardOnTapModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }

}
