//
//  Section.swift
//  TSections-iOS
//
//  Created by Kita, Maksim on 1/14/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import Foundation

public struct Section<S, T> {

    public let section: S

    public let items: [T]

    public let count: Int

    public init(section: S, items: [T]) {
        self.section = section
        self.items = items
        self.count = items.map({ ReflectionUtils.getSectionsArrayFromEnumIfExists(value: $0)?.count ?? 1 }).reduce(0, +)
    }

}

public extension Section where T: Equatable {

    @inline(__always)
    func indexes(of itemToFind: T) -> [Int]? {
        return ArrayUtils.findIndexes(items: items,
                                      itemToFind: itemToFind,
                                      itemCount: { ReflectionUtils.getSectionsArrayFromEnumIfExists(value: $0)?.count ?? 1 })
    }
}
