//
//  Hashable.swift
//  Flow
//
//  Created by Pedro Sousa on 01/09/23.
//

import Foundation

public extension Hashable where Self: Identifiable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

public extension RawRepresentable where Self: Hashable, Self.RawValue == String {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
