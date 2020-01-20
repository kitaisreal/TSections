//
//  SectionsArray.swift
//  TSections
//
//  Created by Kita, Maksim on 1/14/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import Foundation

protocol _SectionsArray {

    var count: Int { get }

    func updateItem(with index: Int)
}

public class SectionsArray<T>: ExpressibleByArrayLiteral {

    public let items: [T]

    public var item: T {
        return updatedItemWithIndex
    }

    var updatedItemWithIndex: T!

    public init(items: [T]) {
        self.items = items
    }

    public required init(arrayLiteral elements: T...) {
        self.items = elements
    }
}

extension SectionsArray: _SectionsArray {

    var count: Int {
        return items.count
    }

    func updateItem(with index: Int) {
        self.updatedItemWithIndex = items[index]
    }
}
