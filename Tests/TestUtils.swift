//
//  TestUtils.swift
//  TSections-iOS
//
//  Created by Kita, Maksim on 1/20/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import XCTest
@testable import TSections

struct TestUtils {

    private init() {}

    static func getSectionArray<T>(item: T) -> SectionsArray<String> {
        guard let sectionsArray = ReflectionUtils.getSectionsArrayFromEnumIfExists(value: item) as? SectionsArray<String> else {
            XCTFail("No section array associated value in item")
            return []
        }
        return sectionsArray
    }
}
