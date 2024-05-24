//
//  AppearanceSettingsView.swift
//  HomeForYou
//
//  Created by Aung Ko Min on 28/1/23.
//

import SwiftUI

public struct SwiftyThemeSettingsView: View {
    
    @State private var showRestoreToDefaultConfirmation = false
    
    public init() {}
    
    public var body: some View {
        List {
            Section {
                SwiftyTintColor._Picker()
            } header: {
                Text("Colors & Styles")
            }
            
            Section {
                SwiftyColorScheme._Picker()
            } header: {
                Text("Color Scheme")
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            
            Section {
                SwiftyFontDesign._Picker()
            } header: {
                Text("Font Design")
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            
            Section {
                Button {
                    showRestoreToDefaultConfirmation = true
                } label: {
                    Text("Restore to default theme")
                }
            } header: {
                Text("Controls")
            }
        }
        .navigationBarTitle("Appearance")
        .confirmationDialog("Restore to defaul theme", isPresented: $showRestoreToDefaultConfirmation) {
            Button(role: .destructive) {
                SwiftyTintColor.reset()
                SwiftyColorScheme.reset()
                SwiftyFontDesign.reset()
            } label: {
                Text("Continue reset theme")
            }
            Button(role: .cancel) {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}
