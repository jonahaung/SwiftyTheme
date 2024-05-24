//
//  File.swift
//  
//
//  Created by Aung Ko Min on 3/7/23.
//

import SwiftUI

public enum SwiftyColorScheme: String, CaseIterable, Identifiable {
    
    case auto = "Auto"
    case light = "Light"
    case dark = "Dark"
    
    public var id: String { rawValue }
    static let key = "com.jonahaung.XColorScheme"
    
    
    static var current: SwiftyColorScheme {
        get {
            let string = UserDefaults.standard.string(forKey: self.key) ?? ""
            return .init(rawValue: string) ?? .auto
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: self.key)
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .auto:
            return nil
        }
    }
    
    public struct _Picker: View {
        @AppStorage(SwiftyColorScheme.key) private var style: SwiftyColorScheme = .current
        public init() {}
        public var body: some View {
            Picker("Color Scheme", selection: $style) {
                ForEach(SwiftyColorScheme.allCases) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
        }
    }
    
    
    struct Modifier: ViewModifier {
        @Environment(\.colorScheme) private var colorScheme: ColorScheme
        @AppStorage(SwiftyColorScheme.key) private var style: SwiftyColorScheme = .current
        
        func body(content: Content) -> some View {
            content
                .colorScheme(style.colorScheme ?? colorScheme)
        }
    }
    
    public static func reset() {
        current = .auto
    }
}
extension View {
    func xColorScheme() -> some View {
        ModifiedContent(content: self, modifier: SwiftyColorScheme.Modifier())
    }
}
