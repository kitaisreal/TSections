//
//  SectionsTests.swift
//  TSections
//
//  Created by Kita, Maksim on 1/14/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import XCTest
@testable import TSections

class SectionsTests: XCTestCase {

    func testBasicCountEmpty() {
        let sections: Sections<TestSection, TestItem> = []
        let actual = sections.count
        let expected = 0
        XCTAssertEqual(actual, expected)
    }

    func testBasicCount() {
        let section: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(section: .basic(nil), items: []),
            Section<TestSection, TestItem>(section: .basic(nil), items: [])
        ]
        let actual = section.count
        let expected = 2
        XCTAssertEqual(actual, expected)
    }

    func testCollectionCount() {
        let sections: Sections<TestSection, TestItem> = [
            Section(section: .collection(["F", "S"]), items: [])
        ]
        let actual = sections.count
        let expected = 2
        XCTAssertEqual(actual, expected)
    }

    func testBasicAndCollectionCount() {
        let sections: Sections<TestSection, TestItem> = [
            Section(section: .basic(nil), items: []),
            Section(section: .collection(["F", "S"]), items: []),
            Section(section: .collection(["F", "S"]), items: [])
        ]
        let actual = sections.count
        let expected = 5
        XCTAssertEqual(actual, expected)
    }

    func testSectionAtIndexBasic() {
        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(section: .basic("F"), items: []),
            Section<TestSection, TestItem>(section: .basic("S"), items: [])
        ]

        XCTAssertEqual(sections.section(at: 0).section, TestSection.basic("F"))
        XCTAssertEqual(sections.section(at: 1).section, TestSection.basic("S"))
    }

    func testSectionAtIndexCollection() {
        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(section: .basic("F"), items: []),
            Section<TestSection, TestItem>(section: .collection(["1", "2", "3"]), items: []),
            Section<TestSection, TestItem>(section: .collection(["4", "5", "6"]), items: [])
        ]

        XCTAssertEqual(sections.section(at: 0).section, TestSection.basic("F"))
        XCTAssertEqual(sections.section(at: 0).count, 0)

        XCTAssertEqual(sections.section(at: 1).section, .collection(["1", "2", "3"]))
        XCTAssertEqual(sections.section(at: 2).section, .collection(["1", "2", "3"]))
        XCTAssertEqual(sections.section(at: 3).section, .collection(["1", "2", "3"]))

        XCTAssertEqual(getSectionArrayFromTestSection(value: sections.section(at: 1).section).item, "1")
        XCTAssertEqual(getSectionArrayFromTestSection(value: sections.section(at: 2).section).item, "2")
        XCTAssertEqual(getSectionArrayFromTestSection(value: sections.section(at: 3).section).item, "3")

        XCTAssertEqual(sections.section(at: 4).section, .collection(["4", "5", "6"]))
        XCTAssertEqual(sections.section(at: 5).section, .collection(["4", "5", "6"]))
        XCTAssertEqual(sections.section(at: 6).section, .collection(["4", "5", "6"]))

        XCTAssertEqual(getSectionArrayFromTestSection(value: sections.section(at: 4).section).item, "4")
        XCTAssertEqual(getSectionArrayFromTestSection(value: sections.section(at: 5).section).item, "5")
        XCTAssertEqual(getSectionArrayFromTestSection(value: sections.section(at: 6).section).item, "6")
    }

    private func getSectionArrayFromTestSection(value: TestSection) -> SectionsArray<String> {
        guard case .collection(let sectionArray) = value else {
            XCTFail("TestSection value is not collection")
            return []
        }
        return sectionArray
    }

    func testItemAtIndexPathBasic() {
        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(section: .basic("F"), items: [.basic("1"), .basic("2")]),
            Section<TestSection, TestItem>(section: .basic("S"), items: [.basic("3"), .basic("4")])
        ]

        XCTAssertEqual(sections.section(at: 0).count, 2)
        XCTAssertEqual(sections.item(at: IndexPath(item: 0, section: 0)), TestItem.basic("1"))
        XCTAssertEqual(sections.item(at: IndexPath(item: 1, section: 0)), TestItem.basic("2"))

        XCTAssertEqual(sections.section(at: 1).count, 2)
        XCTAssertEqual(sections.item(at: IndexPath(item: 0, section: 1)), TestItem.basic("3"))
        XCTAssertEqual(sections.item(at: IndexPath(item: 1, section: 1)), TestItem.basic("4"))
    }

    func testItemAtIndexPathCollection() {
        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(section: .basic("F"), items: [.basic("1"), .basic("2"), .collection(["3", "4"])]),
            Section<TestSection, TestItem>(section: .basic("S"), items: [.basic("5"), .basic("6"), .collection(["7", "8", "9"])])
        ]

        XCTAssertEqual(sections.section(at: 0).count, 4)
        XCTAssertEqual(sections.item(at: IndexPath(item: 0, section: 0)), TestItem.basic("1"))
        XCTAssertEqual(sections.item(at: IndexPath(item: 1, section: 0)), TestItem.basic("2"))
        XCTAssertEqual(getSectionArrayFromTestItem(value: sections.item(at: IndexPath(item: 2, section: 0))).item, "3")
        XCTAssertEqual(getSectionArrayFromTestItem(value: sections.item(at: IndexPath(item: 3, section: 0))).item, "4")

        XCTAssertEqual(sections.section(at: 1).count, 5)
        XCTAssertEqual(sections.item(at: IndexPath(item: 0, section: 1)), TestItem.basic("5"))
        XCTAssertEqual(sections.item(at: IndexPath(item: 1, section: 1)), TestItem.basic("6"))
        XCTAssertEqual(getSectionArrayFromTestItem(value: sections.item(at: IndexPath(item: 2, section: 1))).item, "7")
        XCTAssertEqual(getSectionArrayFromTestItem(value: sections.item(at: IndexPath(item: 3, section: 1))).item, "8")
        XCTAssertEqual(getSectionArrayFromTestItem(value: sections.item(at: IndexPath(item: 4, section: 1))).item, "9")
    }

    func testItemAtIndexPathCollectionBetween() {
        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(section: .basic(nil), items: [.basic("1"), .collection(["2", "3", "4"]), .basic("5")])
        ]

        XCTAssertEqual(sections.section(at: 0).count, 5)

        XCTAssertEqual(sections.item(at: IndexPath(item: 0, section: 0)), TestItem.basic("1"))
        XCTAssertEqual(getSectionArrayFromTestItem(value: sections.item(at: IndexPath(item: 1, section: 0))).item, "2")
        XCTAssertEqual(getSectionArrayFromTestItem(value: sections.item(at: IndexPath(item: 2, section: 0))).item, "3")
        XCTAssertEqual(getSectionArrayFromTestItem(value: sections.item(at: IndexPath(item: 3, section: 0))).item, "4")
        XCTAssertEqual(sections.item(at: IndexPath(item: 4, section: 0)), TestItem.basic("5"))
    }

    private func getSectionArrayFromTestItem(value: TestItem) -> SectionsArray<String> {
        guard case .collection(let sectionsArray) = value else {
            XCTFail("TestItem value is not collection")
            return []
        }
        return sectionsArray
    }

    func testSectionIndexesBasic() {
        let firstSection: TestSection = .basic("1")
        let secondSection: TestSection = .basic("2")

        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(section: firstSection, items: []),
            Section<TestSection, TestItem>(section: secondSection, items: [])
        ]

        let actualFirstItemIndexes = sections.indexes(of: firstSection)
        let expectedFirstItemIndexes = [0]
        XCTAssertEqual(actualFirstItemIndexes, expectedFirstItemIndexes)

        let actualSecondItemIndexes = sections.indexes(of: secondSection)
        let expectedSecondItemIndexes = [1]
        XCTAssertEqual(actualSecondItemIndexes, expectedSecondItemIndexes)

        let actualFirstItemIndexSet = sections.indexSet(of: firstSection)
        let expectedFirstItemIndexSet: IndexSet = [0]
        XCTAssertEqual(actualFirstItemIndexSet, expectedFirstItemIndexSet)

        let actualSecondItemIndexSet = sections.indexSet(of: secondSection)
        let expectedSecondItemIndexSet: IndexSet = [1]
        XCTAssertEqual(actualSecondItemIndexSet, expectedSecondItemIndexSet)
    }

    func testSectionIndexesEmpty() {
        let firstSection: TestSection = .basic("1")
        let secondSection: TestSection = .basic("2")

        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(section: firstSection, items: [])
        ]

        let actualSecondItemIndexes = sections.indexes(of: secondSection)
        let expectedSecondItemIndexes: [Int]? = nil
        XCTAssertEqual(actualSecondItemIndexes, expectedSecondItemIndexes)

        let actualSecondItemIndexSet = sections.indexSet(of: secondSection)
        let expectedSecondItemIndexSet: IndexSet? = nil
        XCTAssertEqual(actualSecondItemIndexSet, expectedSecondItemIndexSet)
    }

//    func testSectionIndexesBasicThenCollection() {
//        let itemSection: TestSection = .basic("1")
//        let collectionSection: TestSection = .collection(["2", "3", "4"])
//
//        let sections: Sections<TestSection, TestItem> = [
//            Section<TestSection, TestItem>(section: itemSection, items: []),
//            Section<TestSection, TestItem>(section: collectionSection, items: [])
//        ]
//
//        let actualItemIndexes = sections.indexes(of: itemSection)
//        let expectedItemIndexes = [0]
//        XCTAssertEqual(actualItemIndexes, expectedItemIndexes)
//
//        let actualCollectionIndexes = sections.indexes(of: collectionSection)
//        let expectedCollectionIndexes = (itemSection.countOfElements..<collectionSection.countOfElements + itemSection.countOfElements).map { $0 }
//        XCTAssertEqual(actualCollectionIndexes, expectedCollectionIndexes)
//
//        let actualItemIndexSet = sections.indexSet(of: itemSection)
//        let expectedItemIndexSet: IndexSet = [0]
//        XCTAssertEqual(actualItemIndexSet, expectedItemIndexSet)

//        let actualCollectionIndexSet = sections.indexSet(of: collectionSection)
//        let expectedCollectionIndexSet: IndexSet = (itemSection.countOfElements..<collectionSection.countOfElements + itemSection.countOfElements).map { $0 }
//        XCTAssertEqual(actualCollectionIndexSet, expectedCollectionIndexSet)
//    }

//    func testSectionIndexesBasicThenCollectionThenBasic() {
//        let firstSection: TestSection = .basic("1")
//        let collectionSection: TestSection = .collection(["2", "3", "4"])
//        let lastSection: TestSection = .basic("5")
//
//        let sections: Sections<TestSection, TestItem> = [
//            Section<TestSection, TestItem>(section: firstSection, items: []),
//            Section<TestSection, TestItem>(section: collectionSection, items: [])
//        ]
//
//        let actualFirstSectionIndexes = sections.indexes(of: firstSection)
//        let expectedFirstSectionIndexes = [0]
//        XCTAssertEqual(actualFirstSectionIndexes, expectedFirstSectionIndexes)
//
//        let actualCollectionIndexes = sections.indexes(of: collectionSection)
//        let expectedCollectionIndexes = (firstSection.countOfElements..<collectionSection.countOfElements + firstSection.countOfElements).map { $0 }
//        XCTAssertEqual(actualCollectionIndexes, expectedCollectionIndexes)
//
//        let actualLastItemIndexes = sections.indexSet(of: lastSection)
//        let expectedLastSectionIndexes = [collectionSection.countOfElements + firstSection.countOfElements]
//
//        let actualFirstItemIndexSet = sections.indexSet(of: firstSection)
//        let expectedItemIndexSet: IndexSet = [0]
//        XCTAssertEqual(actualFirstItemIndexSet, expectedItemIndexSet)

//        let actualCollectionIndexSet = sections.indexSet(of: collectionSection)
//        let expectedCollectionIndexSet: IndexSet = (firstSection.countOfElements..<collectionSection.countOfElements + firstSection.countOfElements).map { $0 }
//        XCTAssertEqual(actualCollectionIndexSet, expectedCollectionIndexSet)
//    }
}
