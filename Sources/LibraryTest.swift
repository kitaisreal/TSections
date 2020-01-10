//
//  LibraryTest.swift
//  LibraryTemplate-iOS
//
//  Created by Kita, Maksim on 12/29/19.
//  Copyright © 2019 Kita, Maksim. All rights reserved.
//

import Foundation

public class LibraryTest {

    public static func getPlatform() -> String {
        let platform: String

        #if os(macOS)
            platform = "macOS"
        #elseif os(iOS)
            platform = "iOS"
        #elseif os(tvOS)
            platform = "tvOS"
        #elseif os(watchOS)
            platform = "watchOS"
        #endif

        return platform
    }
}
