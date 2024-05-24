//
//  _ListStyle.swift
//  HomeForYou
//
//  Created by Aung Ko Min on 25/6/23.
//

import SwiftUI

public enum SwiftyListStyle: String, CaseIterable, Identifiable {
    
    case insetGrouped = "Inset Group"
    case grouped = "Group"
    case plain = "Plain"
    case inset = "Inset"
    case sidebar = "Sidebar"
    
    public var id: String { rawValue }
    
    static let key = "com.jonahaung.listStyle"
    
    static var current: SwiftyListStyle {
        get {
            let string = UserDefaults.standard.string(forKey: SwiftyListStyle.key) ?? ""
            return .init(rawValue: string) ?? .insetGrouped
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: SwiftyListStyle.key)
        }
    }
    
    public static func reset() {
        current = .insetGrouped
    }
    
    public struct _Picker: View {
        @AppStorage(SwiftyListStyle.key) private var value: SwiftyListStyle = .current
        
        public init() {}
        
        public var body: some View {
            Picker("List Style", selection: $value) {
                ForEach(SwiftyListStyle .allCases) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    
    struct Modifier: ViewModifier {
        @AppStorage(SwiftyListStyle.key) private var value: SwiftyListStyle = .current
        func body(content: Content) -> some View {
            switch value {
            case .insetGrouped:
                content.listStyle(.insetGrouped)
            case .grouped:
                content.listStyle(.grouped)
            case .plain:
                content.listStyle(.plain)
            case .inset:
                content.listStyle(.inset)
            case .sidebar:
                content.listStyle(.sidebar)
            }
        }
    }
}

extension View {
    func xListStyle() -> some View {
        ModifiedContent(content: self, modifier: SwiftyListStyle.Modifier())
    }
}
