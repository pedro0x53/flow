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

public extension Hashable where Self: RawRepresentable, RawValue == String {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
