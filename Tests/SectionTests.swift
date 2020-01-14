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

    func testBasicCountEmpty() {
        let section: Section<TestSection, TestItem> = Section(section: .basic(nil), items: [])
        let actual = section.count
        let expected = 0
        XCTAssertEqual(actual, expected)
    }

    func testBasicCount() {
        let section: Section<TestSection, TestItem> = Section(section: .basic(nil), items: [.basic(nil), .basic(nil)])
        let actual = section.count
        let expected = 2
        XCTAssertEqual(actual, expected)
    }

    func testCollectionCount() {
        let section: Section<TestSection, TestItem> = Section(section: .basic(nil), items: [.collection(["F", "S"])])
        let actual = section.count
        let expected = 2
        XCTAssertEqual(actual, expected)
    }

    func testBasicAndCollectionCount() {
        let section: Section<TestSection, TestItem> = Section(section: .basic(nil), items: [.basic(nil),
                                                                                            .collection(["F", "S"]),
                                                                                            .collection(["F", "S"])])
        let actual = section.count
        let expected = 5
        XCTAssertEqual(actual, expected)
    }
}
