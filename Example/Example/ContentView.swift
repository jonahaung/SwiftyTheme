//
//  ContentView.swift
//  Example
//
//  Created by Aung Ko Min on 25/5/24.
//

import SwiftUI
import SwiftyTheme

struct ContentView: View {
    var body: some View {
        NavigationStack {
            SwiftyThemeSettingsView()
                .navigationTitle("Swifty Theme")
        }
        .swiftyThemeStyle()
        
    }
}
