//
//  SectionTests.swift
//  TSections
//
//  Created by Kita, Maksim on 1/14/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import XCTest
@testable import TSections

class SectionTests: XCTestCase {

    // MARK: Count tests

    func testBasicCountEmpty() {
        let section: Section<TestSection, TestItem> = Section(value: .basic(nil), items: [])
        let actual = section.count
        let expected = 0
        XCTAssertEqual(actual, expected)
    }

    func testBasicCount() {
        let section: Section<TestSection, TestItem> = Section(value: .basic(nil), items: [.basic(nil), .basic(nil)])
        let actual = section.count
        let expected = 2
        XCTAssertEqual(actual, expected)
    }

    func testCollectionCount() {
        let section: Section<TestSection, TestItem> = Section(value: .basic(nil), items: [.collection(["F", "S"])])
        let actual = section.count
        let expected = 2
        XCTAssertEqual(actual, expected)
    }

    func testBasicAndCollectionCount() {
        let section: Section<TestSection, TestItem> = Section(value: .basic(nil), items: [.basic(nil),
                                                                                            .collection(["F", "S"]),
                                                                                            .collection(["F", "S"])])
        let actual = section.count
        let expected = 5
        XCTAssertEqual(actual, expected)
    }

    // MARK: Item at index tests

    func testItemAtIndexBasic() {
        let section: Section<TestSection, TestItem> = Section(value: .basic(nil), items: [.basic("1"), .basic("2")])

        let firstItemActual = section.item(at: 0)
        let firstItemExpected: TestItem = .basic("1")
        XCTAssertEqual(firstItemActual, firstItemExpected)

        let secondItemActual = section.item(at: 1)
        let secondItemExpected: TestItem = .basic("2")
        XCTAssertEqual(secondItemActual, secondItemExpected)
    }

    func testItemAtIndexBasicThenCollection() {
        let basicItem: TestItem = .basic("1")
        let collectionItem: TestItem = .collection(["2", "3", "4"])

        let section: Section<TestSection, TestItem> = Section(value: .basic(nil), items: [basicItem, collectionItem])

        let firstBasicItemActual = section.item(at: 0)
        let firstBasicItemExpected: TestItem = .basic("1")
        XCTAssertEqual(firstBasicItemActual, firstBasicItemExpected)

        XCTAssertEqual(TestUtils.getSectionArray(item: section.item(at: 1)).item, "2")
        XCTAssertEqual(TestUtils.getSectionArray(item: section.item(at: 2)).item, "3")
        XCTAssertEqual(TestUtils.getSectionArray(item: section.item(at: 3)).item, "4")
    }

    func testItemAtIndexCollectionThenBasic() {
        let basicItem: TestItem = .basic("1")
        let collectionItem: TestItem = .collection(["2", "3", "4"])

        let section: Section<TestSection, TestItem> = Section(value: .basic(nil), items: [collectionItem, basicItem])

        let lastItemBasicActual = section.item(at: 3)
        let lastItemBasicExpected: TestItem = .basic("1")
        XCTAssertEqual(lastItemBasicActual, lastItemBasicExpected)

        XCTAssertEqual(TestUtils.getSectionArray(item: section.item(at: 0)).item, "2")
        XCTAssertEqual(TestUtils.getSectionArray(item: section.item(at: 1)).item, "3")
        XCTAssertEqual(TestUtils.getSectionArray(item: section.item(at: 2)).item, "4")
    }

    func testItemAtIndexBasicThenCollectionThenBasic() {
        let basicItem: TestItem = .basic("1")
        let collectionItem: TestItem = .collection(["2", "3", "4"])

        let section: Section<TestSection, TestItem> = Section(value: .basic(nil), items: [basicItem, collectionItem, basicItem])

        let firstBasicItemActual = section.item(at: 0)
        let firstBasicItemExpected: TestItem = .basic("1")
        XCTAssertEqual(firstBasicItemActual, firstBasicItemExpected)

        let lastItemBasicActual = section.item(at: 4)
        let lastItemBasicExpected: TestItem = .basic("1")
        XCTAssertEqual(lastItemBasicActual, lastItemBasicExpected)

        XCTAssertEqual(TestUtils.getSectionArray(item: section[1]).item, "2")
        XCTAssertEqual(TestUtils.getSectionArray(item: section[2]).item, "3")
        XCTAssertEqual(TestUtils.getSectionArray(item: section[3]).item, "4")
    }

    func testItemAtIndexMultipleCollections() {
        let firstCollectionItem: TestItem = .collection(["1", "2", "3"])
        let secondCollectionItem: TestItem = .collection(["4", "5", "6"])

        let section: Section<TestSection, TestItem> = Section(value: .basic(nil), items: [firstCollectionItem, secondCollectionItem])

        XCTAssertEqual(TestUtils.getSectionArray(item: section.item(at: 0)).item, "1")
        XCTAssertEqual(TestUtils.getSectionArray(item: section.item(at: 1)).item, "2")
        XCTAssertEqual(TestUtils.getSectionArray(item: section.item(at: 2)).item, "3")

        XCTAssertEqual(TestUtils.getSectionArray(item: section[3]).item, "4")
        XCTAssertEqual(TestUtils.getSectionArray(item: section[4]).item, "5")
        XCTAssertEqual(TestUtils.getSectionArray(item: section[5]).item, "6")
    }
}
