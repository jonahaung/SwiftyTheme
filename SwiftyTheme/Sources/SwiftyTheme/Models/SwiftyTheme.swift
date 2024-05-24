//
//  File.swift
//  
//
//  Created by Aung Ko Min on 3/7/23.
//

import SwiftUI

private struct SwiftyThemeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .xFontDesign()
            .xAccentColor()
            .xColorScheme()
    }
}

public extension View {
    func swiftyThemeStyle() -> some View {
        ModifiedContent(content: self, modifier: SwiftyThemeModifier())
    }
}
