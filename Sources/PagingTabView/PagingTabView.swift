//
//  PagingTabView.swift
//  
//
//  Created by Kristof Kalai on 2022. 08. 30..
//

import SwiftUI

public struct PagingTabView<Content: View> {
    @Binding private var offset: CGFloat
    @Binding private var index: Int
    private let viewSize: CGSize
    private let bounces: Bool
    private let horizontal: Bool
    @ViewBuilder private let content: () -> Content

    public init(offset: Binding<CGFloat>,
                index: Binding<Int>? = nil,
                viewSize: CGSize,
                bounces: Bool = true,
                horizontal: Bool = true,
                @ViewBuilder content: @escaping () -> Content) {
        self._offset = offset
        self._index = index ?? .constant(-1)
        self.viewSize = viewSize
        self.bounces = bounces
        self.horizontal = horizontal
        self.content = content
    }
}

extension PagingTabView: View {
    public var body: some View {
        _PagingTabView(offset: $offset, index: $index, bounces: bounces, viewSize: viewSize, horizontal: horizontal) {
            if horizontal {
                HStack(spacing: .zero) {
                    content()
                        .frame(width: viewSize.width)
                }
            } else {
                VStack(spacing: .zero) {
                    content()
                        .frame(height: viewSize.height)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
