//
//  ReflectionUtils.swift
//  TSections
//
//  Created by Kita, Maksim on 1/14/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import Foundation

struct ReflectionUtils {

    private init() {}

    static func getSectionsArrayFromEnumIfExists<V>(value: V) -> _SectionsArray? {
        let mirror = Mirror(reflecting: value)
        return mirror.children.first?.value as? _SectionsArray
    }
}
