//
//  Sections.swift
//  TSections-iOS
//
//  Created by Kita, Maksim on 1/14/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import Foundation
#if os(macOS)
import AppKit
#else
import UIKit
#endif

public struct Sections<S, T>: ExpressibleByArrayLiteral {

    public let sections: [Section<S, T>]

    public let count: Int

    public init(sections: [Section<S, T>]) {
        self.sections = sections
        self.count = sections.map({ ReflectionUtils.getSectionsArrayFromEnumIfExists(value: $0.section)?.count ?? 1 }).reduce(0, +)
    }

    public init(arrayLiteral elements: Section<S, T>...) {
        self.init(sections: elements)
    }

}

public extension Sections {

    @inline(__always)
    subscript(index: Int) -> Section<S, T> {
        return section(at: index)
    }

    func section(at index: Int) -> Section<S, T> {
        let sectionWithOffset = ArrayUtils.findItem(items: sections,
                            itemIndexToFind: index,
                            itemCount: { ReflectionUtils.getSectionsArrayFromEnumIfExists(value: $0.section)?.count ?? 1 })

        ReflectionUtils.getSectionsArrayFromEnumIfExists(value: sectionWithOffset.item.section)?.updateItem(with: sectionWithOffset.offset)

        return sectionWithOffset.item
    }

}

public extension Sections {

    struct ItemInSection<S, T> {

        public let item: T

        public let section: Section<S, T>

        init(item: T, section: Section<S, T>) {
            self.item = item
            self.section = section
        }
    }

    func itemInSection(at indexPath: IndexPath) -> ItemInSection<S, T> {
        let sectionIndexToFind = indexPath.section
        let itemIndexToFind = indexPath.item

        let sectionToFind = section(at: sectionIndexToFind)
        let itemWithOffset = ArrayUtils.findItem(items: sectionToFind.items,
                                       itemIndexToFind: itemIndexToFind,
                                       itemCount: { ReflectionUtils.getSectionsArrayFromEnumIfExists(value: $0)?.count ?? 1 })

        ReflectionUtils.getSectionsArrayFromEnumIfExists(value: itemWithOffset.item)?.updateItem(with: itemWithOffset.offset)

        return ItemInSection(item: itemWithOffset.item, section: sectionToFind)
    }
}

public extension Sections {

    @inline(__always)
    subscript(indexPath: IndexPath) -> T {
        return item(at: indexPath)
    }

    @inline(__always)
    func item(at indexPath: IndexPath) -> T {
        return itemInSection(at: indexPath).item
    }

}

public extension Sections where S: Equatable {

    func indexSet(of sectionToFind: S) -> IndexSet? {
        let result: IndexSet?

        if let indexes = indexes(of: sectionToFind) {
            result = IndexSet(indexes)
        } else {
            result = nil
        }

        return result
    }

    @inline(__always)
    func indexes(of sectionToFind: S) -> [Int]? {
        return ArrayUtils.findIndexes(items: sections.map { $0.section },
                                      itemToFind: sectionToFind,
                                      itemCount: { ReflectionUtils.getSectionsArrayFromEnumIfExists(value: $0)?.count ?? 1 })
    }
}

public extension Sections where S: Equatable, T: Equatable {

    func indexPaths(of item: T) -> [IndexPath]? {
        var currentSectionIndex: Int = 0

        var indexPaths: [IndexPath]?
        for section in sections {
            let sectionCount: Int = ReflectionUtils.getSectionsArrayFromEnumIfExists(value: section.section)?.count ?? 1

            if let indexesInSection = section.indexes(of: item) {
                indexPaths = indexesInSection.map { IndexPath(item: $0, section: currentSectionIndex) }
                break
            }

            currentSectionIndex += sectionCount
        }

        return indexPaths
    }
}
