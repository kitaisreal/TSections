//
//  ReflectionUtilsTests.swift
//  TSections
//
//  Created by Kita, Maksim on 1/15/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import XCTest
@testable import TSections

class ReflectionUtilsTests: XCTestCase {

    func testGetSectionsArrayFromEnumIfExistsExists() {
        let testSectionArray: SectionsArray<String> = []
        let item: TestSection = .collection(testSectionArray)

        guard let expectedSectionsArray = ReflectionUtils.getSectionsArrayFromEnumIfExists(value: item) as? SectionsArray<String> else {
            XCTFail("TestGetSectionsArrayFromEnumIfExistsExists sections array not found")
            return
        }

        let expected = ObjectIdentifier(testSectionArray)
        let actual = ObjectIdentifier(expectedSectionsArray)
        XCTAssertEqual(actual, expected)
    }

    func testGetSectionsArrayFromEnumIfExistsNotExists() {
        let testItem: TestSection = .basic("1")
        let actual = ReflectionUtils.getSectionsArrayFromEnumIfExists(value: testItem)
        XCTAssertNil(actual)
    }
}
