//
//  File.swift
//  
//
//  Created by Aung Ko Min on 26/6/23.
//

import SwiftUI

public enum SwiftyFontDesign: String, Identifiable, CaseIterable {
    
    case `default`, Serif, Rounded, Monospace
    
    public var id: String { rawValue }
    public static let key = "com.jonahaung.fontDesign"
    
    public var design: Font.Design? {
        switch self {
        case .default:
            return nil
        case .Serif:
            return .serif
        case .Rounded:
            return .rounded
        case .Monospace:
            return .monospaced
        }
    }
    
    public static var current: Self {
        get {
            let string = UserDefaults.standard.string(forKey: self.key) ?? ""
            return .init(rawValue: string) ?? .default
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: self.key)
        }
    }
    public static func reset() {
        current = .default
    }
    public struct _Picker: View {
        @AppStorage(SwiftyFontDesign.key) private var design: SwiftyFontDesign = .default
        public init() {}
        public var body: some View {
            if #available(iOS 16.1, *) {
                Picker("Font Design", selection: $design) {
                    ForEach(SwiftyFontDesign.allCases) {
                        Text($0.rawValue)
                            .fontDesign($0.design)
                            .tag($0)
                    }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
            } else {
                EmptyView()
            }
        }
    }
    
    struct Modifier: ViewModifier {
        @AppStorage(SwiftyFontDesign.key) private var value: SwiftyFontDesign = .default
        func body(content: Content) -> some View {
            if #available(iOS 16.1, *) {
                content.fontDesign(value.design)
            } else {
                content
            }
        }
    }
}
extension View {
    func xFontDesign() -> some View {
        ModifiedContent(content: self, modifier: SwiftyFontDesign.Modifier())
    }
}
