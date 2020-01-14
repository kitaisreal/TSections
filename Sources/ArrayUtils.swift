//
//  ArrayUtils.swift
//  TSections
//
//  Created by Kita, Maksim on 1/14/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import Foundation

struct ItemWithOffset<T> {

    let item: T

    let offset: Int

    init(item: T, offset: Int) {
        self.item = item
        self.offset = offset
    }
}


struct ArrayUtils {

    static func findItem<T>(items: [T], itemIndexToFind: Int, itemCount: (T) -> Int) -> ItemWithOffset<T> {
        var currentItemIndex: Int = 0

        var resultItem: ItemWithOffset<T>?

        for item in items {
            let countOfElementsInItem = itemCount(item)
            let itemEndIndex = currentItemIndex + (countOfElementsInItem - 1)

            if currentItemIndex == itemIndexToFind || itemIndexToFind <= itemEndIndex  {
                let itemIndexOffsetInCollection = itemIndexToFind - currentItemIndex
                resultItem = ItemWithOffset(item: item, offset: itemIndexOffsetInCollection)
                break
            }

            currentItemIndex += countOfElementsInItem
        }

        guard let result = resultItem else {
            fatalError("No such element with index \(itemIndexToFind)")
        }

        return result
    }

    static func findIndexes<T: Equatable>(items: [T], itemToFind: T, itemCount: (T) -> Int) -> [Int]? {
        var currentItemIndex: Int = 0

        var resultIndexes: [Int]?
        for item in items {
            let countOfElementsInItem = itemCount(item)

            if item == itemToFind {
                resultIndexes = (currentItemIndex..<currentItemIndex+countOfElementsInItem).map { $0 }
                break
            }

            currentItemIndex += countOfElementsInItem
        }

        return resultIndexes
    }
}
