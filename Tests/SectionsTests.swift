//
//  SectionsTests.swift
//  TSections
//
//  Created by Kita, Maksim on 1/14/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import XCTest
@testable import TSections

// swiftlint:disable:next type_body_length
class SectionsTests: XCTestCase {

    // MARK: Count tests

    func testBasicCountEmpty() {
        let sections: Sections<TestSection, TestItem> = []
        let actual = sections.count
        let expected = 0
        XCTAssertEqual(actual, expected)
    }

    func testBasicCount() {
        let section: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: .basic(nil), items: []),
            Section<TestSection, TestItem>(value: .basic(nil), items: [])
        ]
        let actual = section.count
        let expected = 2
        XCTAssertEqual(actual, expected)
    }

    func testCollectionCount() {
        let sections: Sections<TestSection, TestItem> = [
            Section(value: .collection(["1", "2"]), items: [])
        ]
        let actual = sections.count
        let expected = 2
        XCTAssertEqual(actual, expected)
    }

    func testBasicAndCollectionCount() {
        let sections: Sections<TestSection, TestItem> = [
            Section(value: .basic(nil), items: []),
            Section(value: .collection(["1", "2"]), items: []),
            Section(value: .collection(["1", "2"]), items: [])
        ]
        let actual = sections.count
        let expected = 5
        XCTAssertEqual(actual, expected)
    }

    // MARK: Section at index tests

    func testSectionAtIndexBasic() {
        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: .basic("1"), items: []),
            Section<TestSection, TestItem>(value: .basic("2"), items: [])
        ]

        XCTAssertEqual(sections.section(at: 0).value, TestSection.basic("1"))
        XCTAssertEqual(sections.section(at: 1).value, TestSection.basic("2"))
    }

    func testSectionAtIndexBasicThenCollection() {
        let basicSection: Section<TestSection, TestItem> = Section(value: .basic("1"),
                                                                   items: [])
        let collectionSection: Section<TestSection, TestItem> = Section(value: .collection(["2", "3", "4"]),
                                                                        items: [])

        let sections: Sections<TestSection, TestItem> = [
            basicSection,
            collectionSection
        ]

        let firstSectionValueActual: TestSection = sections.section(at: 0).value
        let firstSectionValueExpected: TestSection = .basic("1")
        XCTAssertEqual(firstSectionValueActual, firstSectionValueExpected)

        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 1).value).item, "2")
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 2).value).item, "3")
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 3).value).item, "4")
    }

    func testSectionAtIndexCollectionThenBasic() {
        let basicSection: Section<TestSection, TestItem> = Section(value: .basic("1"),
                                                                   items: [])
        let collectionSection: Section<TestSection, TestItem> = Section(value: .collection(["2", "3", "4"]),
                                                                        items: [])

        let sections: Sections<TestSection, TestItem> = [
            collectionSection,
            basicSection
        ]

        let firstSectionValueActual: TestSection = sections.section(at: 3).value
        let firstSectionValueExpected: TestSection = .basic("1")
        XCTAssertEqual(firstSectionValueActual, firstSectionValueExpected)

        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 0).value).item, "2")
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 1).value).item, "3")
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 2).value).item, "4")
    }

    func testSectionAtIndexBasicThenCollectionThenBasic() {
        let basicSection: Section<TestSection, TestItem> = Section(value: .basic("1"),
                                                                   items: [])
        let collectionSection: Section<TestSection, TestItem> = Section(value: .collection(["2", "3", "4"]),
                                                                        items: [])

        let sections: Sections<TestSection, TestItem> = [
            basicSection,
            collectionSection,
            basicSection
        ]

        let firstSectionValueActual: TestSection = sections.section(at: 0).value
        let firstSectionValueExpected: TestSection = .basic("1")
        XCTAssertEqual(firstSectionValueActual, firstSectionValueExpected)

        let lastSectionValueActual: TestSection = sections.section(at: 4).value
        let lastSectionValueExpected: TestSection = .basic("1")
        XCTAssertEqual(lastSectionValueActual, lastSectionValueExpected)

        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 1).value).item, "2")
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 2).value).item, "3")
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 3).value).item, "4")
    }

    func testSectionAtIndexMultipleCollections() {
        let firstCollectionSection: Section<TestSection, TestItem> = Section(value: .collection(["1", "2", "3"]),
                                                                             items: [])
        let secondCollectionSection: Section<TestSection, TestItem> = Section(value: .collection(["4", "5", "6"]),
                                                                             items: [])

        let sections: Sections<TestSection, TestItem> = [
            firstCollectionSection,
            secondCollectionSection
        ]

        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 0).value).item, "1")
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 1).value).item, "2")
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 2).value).item, "3")

        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 3).value).item, "4")
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 4).value).item, "5")
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.section(at: 5).value).item, "6")
    }

    // MARK: Item at index path tests

    func testItemAtIndexPathBasic() {
        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: .basic("1"), items: [.basic("1"), .basic("2")]),
            Section<TestSection, TestItem>(value: .basic("2"), items: [.basic("3"), .basic("4")])
        ]

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 0)).item, .basic("1"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 0)).section.value, .basic("1"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 0)).item, .basic("2"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 0)).section.value, .basic("1"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 1)).item, .basic("3"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 1)).section.value, .basic("2"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 1)).item, .basic("4"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 1)).section.value, .basic("2"))
    }

    func testItemAtIndexPathBasicThenCollection() {
        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: .basic("1"), items: [.basic("1"), .basic("2"), .collection(["3", "4"])]),
            Section<TestSection, TestItem>(value: .basic("2"), items: [.basic("5"), .basic("6"), .collection(["7", "8"])])
        ]

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 0)).item, .basic("1"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 0)).section.value, .basic("1"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 0)).item, .basic("2"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 0)).section.value, .basic("1"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 0)).item, .collection(["3", "4"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 0)).section.value, .basic("1"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 2, section: 0)).item).item, "3")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 0)).item, .collection(["3", "4"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 0)).section.value, .basic("1"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 3, section: 0)).item).item, "4")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 1)).item, .basic("5"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 1)).section.value, .basic("2"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 1)).item, .basic("6"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 1)).section.value, .basic("2"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 1)).item, .collection(["7", "8"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 1)).section.value, .basic("2"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 2, section: 1)).item).item, "7")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 1)).item, .collection(["7", "8"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 1)).section.value, .basic("2"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 3, section: 1)).item).item, "8")
    }

    func testItemAtIndexPathCollectionThenBasic() {
        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: .basic("1"), items: [.collection(["3", "4"]), .basic("1"), .basic("2")]),
            Section<TestSection, TestItem>(value: .basic("2"), items: [.collection(["7", "8"]), .basic("5"), .basic("6")])
        ]

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 0)).item, .collection(["3", "4"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 0)).section.value, .basic("1"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 0, section: 0)).item).item, "3")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 0)).item, .collection(["3", "4"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 0)).section.value, .basic("1"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 1, section: 0)).item).item, "4")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 0)).item, .basic("1"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 0)).section.value, .basic("1"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 0)).item, .basic("2"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 0)).section.value, .basic("1"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 1)).item, .collection(["7", "8"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 1)).section.value, .basic("2"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 0, section: 1)).item).item, "7")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 1)).item, .collection(["7", "8"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 1)).section.value, .basic("2"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 1, section: 1)).item).item, "8")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 1)).item, .basic("5"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 1)).section.value, .basic("2"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 1)).item, .basic("6"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 1)).section.value, .basic("2"))
    }

    func testItemAtIndexPathBasicThenCollectionThenBasic() {
        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: .basic("1"), items: [.basic("1"), .basic("2"), .collection(["3", "4"]), .basic("5")]),
            Section<TestSection, TestItem>(value: .basic("2"), items: [.basic("6"), .basic("7"), .collection(["8", "9"]), .basic("10")])
        ]

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 0)).item, .basic("1"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 0)).section.value, .basic("1"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 0)).item, .basic("2"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 0)).section.value, .basic("1"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 0)).item, .collection(["3", "4"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 0)).section.value, .basic("1"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 2, section: 0)).item).item, "3")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 0)).item, .collection(["3", "4"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 0)).section.value, .basic("1"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 3, section: 0)).item).item, "4")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 4, section: 0)).item, .basic("5"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 4, section: 0)).section.value, .basic("1"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 1)).item, .basic("6"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 1)).section.value, .basic("2"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 1)).item, .basic("7"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 1)).section.value, .basic("2"))

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 1)).item, .collection(["8", "9"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 1)).section.value, .basic("2"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 2, section: 1)).item).item, "8")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 1)).item, .collection(["8", "9"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 1)).section.value, .basic("2"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 3, section: 1)).item).item, "9")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 4, section: 1)).item, .basic("10"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 4, section: 1)).section.value, .basic("2"))
    }

    func testItemAtIndexPathMultipleCollections() {
        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: .basic("1"), items: [.collection(["1", "2"]), .collection(["3"]), .collection(["4"])])
        ]

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 0)).item, .collection(["1", "2"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 0)).section.value, .basic("1"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 0, section: 0)).item).item, "1")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 0)).item, .collection(["1", "2"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 0)).section.value, .basic("1"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 1, section: 0)).item).item, "2")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 0)).item, .collection(["3"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 2, section: 0)).section.value, .basic("1"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 2, section: 0)).item).item, "3")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 0)).item, .collection(["4"]))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 3, section: 0)).section.value, .basic("1"))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections.itemInSection(at: IndexPath(item: 3, section: 0)).item).item, "4")
    }

    func testItemAtIndexPathSectionCollection() {
        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: .collection(["1", "2"]), items: [.basic("1"), .basic("2")])
        ]

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 0)).item, .basic("1"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 0)).section.value, .collection(["1", "2"]))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections[IndexPath(item: 0, section: 0)].section.value).item, "1")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 0)).item, .basic("2"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 0)).section.value, .collection(["1", "2"]))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections[IndexPath(item: 1, section: 0)].section.value).item, "1")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 1)).item, .basic("1"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 0, section: 1)).section.value, .collection(["1", "2"]))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections[IndexPath(item: 0, section: 1)].section.value).item, "2")

        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 1)).item, .basic("2"))
        XCTAssertEqual(sections.itemInSection(at: IndexPath(item: 1, section: 1)).section.value, .collection(["1", "2"]))
        XCTAssertEqual(TestUtils.getSectionArray(item: sections[IndexPath(item: 1, section: 1)].section.value).item, "2")
    }

    // MARK: Indexes of section tests

    func testSectionIndexesBasic() {
        let firstSection: TestSection = .basic("1")
        let secondSection: TestSection = .basic("2")

        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: firstSection, items: []),
            Section<TestSection, TestItem>(value: secondSection, items: [])
        ]

        let firstItemIndexesExpected: [Int]? = sections.indexes(of: firstSection)
        let firstItemIndexesActual: [Int] = [0]
        XCTAssertEqual(firstItemIndexesExpected, firstItemIndexesActual)

        let secondItemIndexesActual: [Int]? = sections.indexes(of: secondSection)
        let secondItemIndexesExpected: [Int] = [1]
        XCTAssertEqual(secondItemIndexesActual, secondItemIndexesExpected)

        let firstItemIndexSetActual: IndexSet? = sections.indexSet(of: firstSection)
        let firstItemIndexSetExpected: IndexSet = [0]
        XCTAssertEqual(firstItemIndexSetActual, firstItemIndexSetExpected)

        let secondItemIndexSetActual: IndexSet? = sections.indexSet(of: secondSection)
        let secondItemIndexSetExpected: IndexSet = [1]
        XCTAssertEqual(secondItemIndexSetActual, secondItemIndexSetExpected)
    }

    func testSectionIndexesNotExists() {
        let firstSection: TestSection = .basic("1")
        let secondSection: TestSection = .basic("2")

        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: firstSection, items: [])
        ]

        let secondItemIndexesActual: [Int]? = sections.indexes(of: secondSection)
        let secondItemIndexesExpected: [Int]? = nil
        XCTAssertEqual(secondItemIndexesActual, secondItemIndexesExpected)

        let secondItemIndexSetActual: IndexSet? = sections.indexSet(of: secondSection)
        let secondItemIndexSetExpected: IndexSet? = nil
        XCTAssertEqual(secondItemIndexSetActual, secondItemIndexSetExpected)
    }

    func testSectionIndexesBasicThenCollection() {
        let basicSection: TestSection = .basic("1")
        let collectionSection: TestSection = .collection(["2", "3", "4"])

        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: basicSection, items: []),
            Section<TestSection, TestItem>(value: collectionSection, items: [])
        ]

        let itemIndexesActual: [Int]? = sections.indexes(of: basicSection)
        let itemIndexesExpected: [Int] = [0]
        XCTAssertEqual(itemIndexesActual, itemIndexesExpected)

        let collectionIndexesActual: [Int]? = sections.indexes(of: collectionSection)
        let collectionIndexesExpected: [Int] = [1, 2, 3]
        XCTAssertEqual(collectionIndexesActual, collectionIndexesExpected)
    }

    func testSectionIndexesCollectionThenBasic() {
        let collectionSection: TestSection = .collection(["2", "3", "4"])
        let basicSection: TestSection = .basic("1")

        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: collectionSection, items: []),
            Section<TestSection, TestItem>(value: basicSection, items: [])
        ]

        let itemIndexesActual: [Int]? = sections.indexes(of: basicSection)
        let itemIndexesExpected: [Int] = [3]
        XCTAssertEqual(itemIndexesActual, itemIndexesExpected)

        let collectionIndexesActual: [Int]? = sections.indexes(of: collectionSection)
        let collectionIndexesExpected: [Int] = [0, 1, 2]
        XCTAssertEqual(collectionIndexesActual, collectionIndexesExpected)
    }

    func testSectionIndexesBasicThenCollectionThenBasic() {
        let firstSection: TestSection = .basic("1")
        let lastSection: TestSection = .basic("5")
        let collectionSection: TestSection = .collection(["2", "3", "4"])

        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: firstSection, items: []),
            Section<TestSection, TestItem>(value: collectionSection, items: []),
            Section<TestSection, TestItem>(value: lastSection, items: [])
        ]

        let firstItemIndexesActual: [Int]? = sections.indexes(of: firstSection)
        let firstItemIndexesExpected: [Int] = [0]
        XCTAssertEqual(firstItemIndexesActual, firstItemIndexesExpected)

        let lastItemIndexesActual: [Int]? = sections.indexes(of: lastSection)
        let lastItemIndexesExpected: [Int] = [4]
        XCTAssertEqual(lastItemIndexesActual, lastItemIndexesExpected)

        let collectionIndexesActual: [Int]? = sections.indexes(of: collectionSection)
        let collectionIndexesExpected: [Int] = [1, 2, 3]
        XCTAssertEqual(collectionIndexesActual, collectionIndexesExpected)
    }

    func testSectionIndexesMultipleCollections() {
        let firstCollectionSection: TestSection = .collection(["1", "2", "3"])
        let secondCollectionSection: TestSection = .collection(["4", "5", "6"])

        let sections: Sections<TestSection, TestItem> = [
            Section<TestSection, TestItem>(value: firstCollectionSection, items: []),
            Section<TestSection, TestItem>(value: secondCollectionSection, items: [])
        ]

        let firstCollectionIndexesActual: [Int]? = sections.indexes(of: firstCollectionSection)
        let firstCollectionIndexesExpected: [Int] = [0, 1, 2]
        XCTAssertEqual(firstCollectionIndexesActual, firstCollectionIndexesExpected)

        let secondCollectionIndexesActual: [Int]? = sections.indexes(of: secondCollectionSection)
        let secondCollectionIndexesExpected: [Int] = [3, 4, 5]
        XCTAssertEqual(secondCollectionIndexesActual, secondCollectionIndexesExpected)
    }
}
// swiftlint:disable:this file_length
