//
//  Color+Extensions.swift
//  Example
//
//  Created by Kristof Kalai on 2022. 08. 30..
//

import SwiftUI

extension Color {
    static func of(index: Int) -> Color {
        switch index {
        case ...0: return .gray
        case 1: return .green
        case 2: return .red
        case 3: return .blue
        default: return .brown
        }
    }
}
