//
//  File.swift
//  
//
//  Created by Aung Ko Min on 3/7/23.
//

import SwiftUI

public enum SwiftyTintColor {
    
    static let key = "com.jonahaung.XAccentColor"
    
    static var current: Color {
        get {
            guard let accentColor = UserDefaults.standard.string(forKey: Self.key), !accentColor.isEmpty else {
                return .accentColor
            }
            return Color(hex: accentColor)
        }
        set {
            UserDefaults.standard.setValue(newValue.toHex(), forKey: Self.key)
        }
    }
    
    public static func reset() {
        UserDefaults.standard.set(nil, forKey: Self.key)
    }
    
    public struct _Picker: View {
        public init() {}
        public var body: some View {
            ColorPicker("Tint Color", selection: .init(get: {
                SwiftyTintColor.current
            }, set: { newValue in
                SwiftyTintColor.current = Color(hex: newValue.toHex() ?? "")
            }), supportsOpacity: true)
        }
    }
    
    struct Modifier: ViewModifier {
        @AppStorage(SwiftyTintColor.key) private var value: String = SwiftyTintColor.current.toHex() ?? ""
        func body(content: Content) -> some View {
            content
                .tint(Color(hex: value))
        }
    }
    
}
extension View {
    func xAccentColor() -> some View {
        ModifiedContent(content: self, modifier: SwiftyTintColor.Modifier())
    }
}
