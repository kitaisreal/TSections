//
//  SectionsTestEnum.swift
//  TSections
//
//  Created by Kita, Maksim on 1/14/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import Foundation
@testable import TSections

enum TestSection: Equatable {
    case basic(String?)
    case collection(SectionsArray<String>)

    var countOfElements: Int {
        let result: Int

        switch self {

        case .basic:
            result = 1
        case .collection(let sectionsArray):
            result = sectionsArray.items.count
        }

        return result
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        let result: Bool

        switch (lhs, rhs) {

        case (.basic(let first), .basic(let second)):
            result = first == second
        case (.collection(let first), .collection(let second)):
            result = first.items == second.items
        case (_, _):
            result = false
        }

        return result
    }
}

extension TestSection: SectionEquatable {

    static func isEqual(lhs: TestSection, rhs: TestSection) -> Bool {
        return lhs == rhs
    }
}

enum TestItem: Equatable {
    case basic(String?)
    case collection(SectionsArray<String>)

    static func == (lhs: Self, rhs: Self) -> Bool {
        let result: Bool

        switch (lhs, rhs) {

        case (.basic(let first), .basic(let second)):
            result = first == second
        case (.collection(let first), .collection(let second)):
            result = first.items == second.items
        case (_, _):
            result = false
        }

        return result
    }
}

extension TestItem: SectionEquatable {

    static func isEqual(lhs: TestItem, rhs: TestItem) -> Bool {
        return lhs == rhs
    }
}
