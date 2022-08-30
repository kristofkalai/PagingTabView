//
//  ExampleApp.swift
//  Example
//
//  Created by Kristof Kalai on 2022. 08. 30..
//

import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader {
                ContentView(viewSize: $0.size)
            }
        }
    }
}
