//
//  SegmentedControl.swift
//
//
//  Created by Kristof Kalai on 2022. 08. 30..
//

import SwiftUI

public struct SegmentedControl {
    private let title: String
    private let items: [String]
    @Binding private var selectedSegmentIndex: Int

    public init(title: String = .init(), items: [String], selectedSegmentIndex: Binding<Int>) {
        self.title = title
        self.items = items
        self._selectedSegmentIndex = selectedSegmentIndex
    }
}

extension SegmentedControl: View {
    public var body: some View {
        Picker(title, selection: $selectedSegmentIndex) {
            ForEach(0..<items.count, id: \.self) {
                Text(items[$0]).tag($0)
            }
        }
        .pickerStyle(.segmented)
    }
}
