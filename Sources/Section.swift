//
//  Section.swift
//  TSections-iOS
//
//  Created by Kita, Maksim on 1/14/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import Foundation

public struct Section<S, T> {

    public let value: S

    public let items: [T]

    public let count: Int

    public init(value: S, items: [T]) {
        self.value = value
        self.items = items
        self.count = items.map({ ReflectionUtils.getSectionsArrayFromEnumIfExists(value: $0)?.count ?? 1 }).reduce(0, +)
    }
}

public extension Section {

    @inline(__always)
    subscript(index: Int) -> T {
        return item(at: index)
    }

    func item(at index: Int) -> T {
        let itemWithOffset = ArrayUtils.findItem(items: items,
                                   itemIndexToFind: index,
                                   itemCount: { ReflectionUtils.getSectionsArrayFromEnumIfExists(value: $0)?.count ?? 1 })

        ReflectionUtils.getSectionsArrayFromEnumIfExists(value: itemWithOffset.item)?.updateItem(with: itemWithOffset.offset)
        return itemWithOffset.item
    }
}

public extension Section where T: SectionEquatable {

    @inline(__always)
    func indexes(of itemToFind: T) -> [Int]? {
        return ArrayUtils.findIndexes(items: items,
                                      itemToFind: itemToFind,
                                      itemCount: { ReflectionUtils.getSectionsArrayFromEnumIfExists(value: $0)?.count ?? 1 })
    }
}
