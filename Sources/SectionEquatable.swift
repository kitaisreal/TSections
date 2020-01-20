//
//  SectionEquatable.swift
//  TSections
//
//  Created by Kita, Maksim on 1/20/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import Foundation

public protocol SectionEquatable {
    static func isEqual(lhs: Self, rhs: Self) -> Bool
}
