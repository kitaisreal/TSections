//
//  ArrayUtilsTests.swift
//  TSections
//
//  Created by Kita, Maksim on 1/14/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import XCTest
@testable import TSections

class ArrayUtilsTests: XCTestCase {

    private enum ArrayUtilEnum: Equatable, SectionEquatable {
        case item(Int, String)

        var countOfElements: Int {
            let result: Int

            switch self {

            case .item(let count, _):
                result = count
            }

            return result
        }

        static func == (lhs: Self, rhs: Self) -> Bool {
            let result: Bool

            switch (lhs, rhs) {

            case (.item(let countFirst, let identifierFirst), .item(let countSecond, let identifierSecond)):
                result = countFirst == countSecond && identifierFirst == identifierSecond
            }

            return result
        }

        static func isEqual(lhs: Self, rhs: Self) -> Bool {
            return lhs == rhs
        }
    }

    // MARK: Find item tests

    func testFindItemBasic() {
        let items: [ArrayUtilEnum] = (0..<5).map { ArrayUtilEnum.item(1, String($0)) }

        for index in 0..<5 {
            let item = ArrayUtils.findItem(items: items, itemIndexToFind: index, itemCount: { $0.countOfElements })
            XCTAssertEqual(item.offset, 0)
            XCTAssertEqual(item.item, ArrayUtilEnum.item(1, String(index)))
        }
    }

    func testFindItemBasicThenCollection() {
        let firstBasicItem: ArrayUtilEnum = .item(1, "1")

        let collectionCount: Int = 5
        let collectionItem: ArrayUtilEnum = .item(collectionCount, "2")

        let items: [ArrayUtilEnum] = [firstBasicItem, collectionItem]

        let firstItem = ArrayUtils.findItem(items: items, itemIndexToFind: 0, itemCount: { $0.countOfElements })

        XCTAssertEqual(firstItem.item, ArrayUtilEnum.item(1, "1"))
        XCTAssertEqual(firstItem.offset, 0)

        for index in firstBasicItem.countOfElements..<collectionCount+firstBasicItem.countOfElements {
            let itemInCollection = ArrayUtils.findItem(items: items, itemIndexToFind: index, itemCount: { $0.countOfElements })
            XCTAssertEqual(itemInCollection.item, collectionItem)
            XCTAssertEqual(itemInCollection.offset, index - firstBasicItem.countOfElements)
        }
    }

    func testFindItemCollectionThenBasic() {
        let firstBasicItem: ArrayUtilEnum = .item(1, "1")

        let collectionCount: Int = 5
        let collectionItem: ArrayUtilEnum = .item(collectionCount, "2")

        let items: [ArrayUtilEnum] = [collectionItem, firstBasicItem]

        let firstItem = ArrayUtils.findItem(items: items, itemIndexToFind: collectionCount, itemCount: { $0.countOfElements })

        XCTAssertEqual(firstItem.item, firstBasicItem)
        XCTAssertEqual(firstItem.offset, 0)

        for index in 0..<collectionCount {
            let itemInCollection = ArrayUtils.findItem(items: items, itemIndexToFind: index, itemCount: { $0.countOfElements })
            XCTAssertEqual(itemInCollection.item, collectionItem)
            XCTAssertEqual(itemInCollection.offset, index)
        }
    }

    func testFindItemBasicThenCollectionThenBasic() {
        let basicItem: ArrayUtilEnum = .item(1, "1")

        let collectionCount: Int = 5
        let collectionItem: ArrayUtilEnum = .item(collectionCount, "2")

        let items: [ArrayUtilEnum] = [basicItem, collectionItem, basicItem]

        let firstItem = ArrayUtils.findItem(items: items, itemIndexToFind: 0, itemCount: { $0.countOfElements })

        XCTAssertEqual(firstItem.item, basicItem)
        XCTAssertEqual(firstItem.offset, 0)

        let lastItem = ArrayUtils.findItem(items: items, itemIndexToFind: collectionCount + basicItem.countOfElements, itemCount: { $0.countOfElements })

        XCTAssertEqual(lastItem.item, basicItem)
        XCTAssertEqual(lastItem.offset, 0)

        for index in basicItem.countOfElements..<collectionCount+basicItem.countOfElements {
            let itemInCollection = ArrayUtils.findItem(items: items, itemIndexToFind: index, itemCount: { $0.countOfElements })
            XCTAssertEqual(itemInCollection.item, collectionItem)
            XCTAssertEqual(itemInCollection.offset, index-basicItem.countOfElements)
        }
    }

    func testFindItemMultipleCollections() {
        let firstCollectionCount: Int = 5
        let firstCollectionItem: ArrayUtilEnum = .item(firstCollectionCount, "1")

        let secondCollectionCount: Int = 5
        let secondCollectionItem: ArrayUtilEnum = .item(secondCollectionCount, "2")

        let items: [ArrayUtilEnum] = [firstCollectionItem, secondCollectionItem]

        for index in 0..<firstCollectionItem.countOfElements {
            let itemInCollection = ArrayUtils.findItem(items: items, itemIndexToFind: index, itemCount: { $0.countOfElements })
            XCTAssertEqual(itemInCollection.item, firstCollectionItem)
            XCTAssertEqual(itemInCollection.offset, index)
        }

        for index in firstCollectionItem.countOfElements..<secondCollectionItem.countOfElements+firstCollectionItem.countOfElements {
            let itemInCollection = ArrayUtils.findItem(items: items, itemIndexToFind: index, itemCount: { $0.countOfElements })
            XCTAssertEqual(itemInCollection.item, secondCollectionItem)
            XCTAssertEqual(itemInCollection.offset, index-firstCollectionItem.countOfElements)
        }
    }

    // MARK: Find indexes tests

    func testFindIndexesBasic() {
        let firstItem: ArrayUtilEnum = .item(1, "1")
        let secondItem: ArrayUtilEnum = .item(1, "2")

        let items: [ArrayUtilEnum] = [firstItem, secondItem]

        let firstItemIndexes = ArrayUtils.findIndexes(items: items, itemToFind: firstItem, itemCount: { $0.countOfElements })
        let secondItemIndexes = ArrayUtils.findIndexes(items: items, itemToFind: secondItem, itemCount: { $0.countOfElements })

        XCTAssertEqual(firstItemIndexes, [0])
        XCTAssertEqual(secondItemIndexes, [1])
    }

    func testFindIndexesNotExists() {
        let firstItem: ArrayUtilEnum = .item(1, "1")
        let secondItem: ArrayUtilEnum = .item(1, "2")

        let items: [ArrayUtilEnum] = [firstItem]

        let actual = ArrayUtils.findIndexes(items: items, itemToFind: secondItem, itemCount: { $0.countOfElements })
        let expected: [Int]? = nil

        XCTAssertEqual(actual, expected)
    }

    func testFindIndexesCollection() {
        let collectionCount: Int = 5
        let collectionItem: ArrayUtilEnum = .item(collectionCount, "1")

        let items: [ArrayUtilEnum] = [collectionItem]

        let actual = ArrayUtils.findIndexes(items: items, itemToFind: collectionItem, itemCount: { $0.countOfElements })
        let expected = (0..<5).map { $0 }

        XCTAssertEqual(actual, expected)
    }

    func testFindIndexesBasicThenCollection() {
        let basicFirstItem: ArrayUtilEnum = .item(1, "1")

        let collectionCount: Int = 5
        let collectionItem: ArrayUtilEnum = .item(collectionCount, "2")

        let items: [ArrayUtilEnum] = [basicFirstItem, collectionItem]

        let itemIndexesActual = ArrayUtils.findIndexes(items: items, itemToFind: basicFirstItem, itemCount: { $0.countOfElements })
        let itemIndexesExpected = [0]

        XCTAssertEqual(itemIndexesActual, itemIndexesExpected)

        let collectionIndexesActual = ArrayUtils.findIndexes(items: items, itemToFind: collectionItem, itemCount: { $0.countOfElements })
        let collectionIndexesExpected = (basicFirstItem.countOfElements..<collectionCount+basicFirstItem.countOfElements).map { $0 }

        XCTAssertEqual(collectionIndexesActual, collectionIndexesExpected)
    }

    func testFindIndexesBasicThenCollectionThenBasic() {
        let basicFirstItem: ArrayUtilEnum = .item(1, "1")
        let basicLastItem: ArrayUtilEnum = .item(1, "3")

        let collectionCount: Int = 5
        let collectionItem: ArrayUtilEnum = .item(collectionCount, "2")

        let items: [ArrayUtilEnum] = [basicFirstItem, collectionItem, basicLastItem]

        let firstItemIndexesActual = ArrayUtils.findIndexes(items: items, itemToFind: basicFirstItem, itemCount: { $0.countOfElements })
        let firstItemIndexesExpected = [0]

        XCTAssertEqual(firstItemIndexesActual, firstItemIndexesExpected)

        let lastItemIndexesActual = ArrayUtils.findIndexes(items: items, itemToFind: basicLastItem, itemCount: { $0.countOfElements })
        let lastItemIndexesExpected = [collectionCount+basicFirstItem.countOfElements]

        XCTAssertEqual(lastItemIndexesActual, lastItemIndexesExpected)

        let collectionIndexesActual = ArrayUtils.findIndexes(items: items, itemToFind: collectionItem, itemCount: { $0.countOfElements })
        let collectionIndexesExpected = (basicFirstItem.countOfElements..<collectionCount+basicFirstItem.countOfElements).map { $0 }

        XCTAssertEqual(collectionIndexesActual, collectionIndexesExpected)
    }

    func testFindIndexesMultipleCollections() {
        let firstCollectionCount: Int = 5
        let firstCollection: ArrayUtilEnum = .item(firstCollectionCount, "1")

        let secondCollectionCount: Int = 5
        let secondCollection: ArrayUtilEnum = .item(secondCollectionCount, "2")

        let items: [ArrayUtilEnum] = [firstCollection, secondCollection]

        let firstItemIndexesActual = ArrayUtils.findIndexes(items: items, itemToFind: firstCollection, itemCount: { $0.countOfElements })
        let firstItemIndexesExpected = (0..<firstCollectionCount).map { $0 }

        XCTAssertEqual(firstItemIndexesActual, firstItemIndexesExpected)

        let secondItemIndexesActual = ArrayUtils.findIndexes(items: items, itemToFind: secondCollection, itemCount: { $0.countOfElements })
        let secondItemIndexesExpected = (firstCollectionCount..<firstCollectionCount+secondCollectionCount).map { $0 }

        XCTAssertEqual(secondItemIndexesActual, secondItemIndexesExpected)
    }
}
