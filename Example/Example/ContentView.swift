//
//  ContentView.swift
//  Example
//
//  Created by Kristof Kalai on 2022. 08. 30..
//

import PagingTabView
import SwiftUI

struct ContentView {
    private let viewSize: CGSize
    private let horizontal: Bool
    @ObservedObject private var viewModel: PagingTabViewViewModel

    init(viewSize: CGSize, horizontal: Bool = true) {
        self.viewSize = viewSize
        self.horizontal = horizontal
        self.viewModel = PagingTabViewViewModel(viewSize: viewSize, horizontal: horizontal)
    }
}

extension ContentView: View {
    var body: some View {
        Group {
            if horizontal {
                horizontalExample
            } else {
                verticalExample
            }
        }
        .onAppear(perform: onAppear)
    }
}

extension ContentView {
    private func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            viewModel.set(index: 2)
        }
    }

    private var content: some View {
        ForEach(0...4, id: \.self) { index in
            Image(systemName: "circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.of(index: index))
        }
    }

    private var image: some View {
        Text("\(viewModel.index). page, offset: \(String(Double(viewModel.offset))), viewSize: \(String(Double(horizontal ? viewSize.width : viewSize.height)))")
            .lineLimit(3)
            .frame(width: 125)
            .background(Color.of(index: viewModel.currentIndex))
            .animation(.easeInOut, value: viewModel.currentIndex)
    }

    private var horizontalExample: some View {
        VStack {
            SegmentedControl(items: ["Gray", "Green", "Red", "Blue", "Brown"], selectedSegmentIndex: $viewModel.segmentIndex)
            pagingTabView
            image
                .frame(width: viewSize.width)
        }
    }

    private var verticalExample: some View {
        HStack {
            pagingTabView
            image
                .frame(height: viewSize.height)
        }
    }

    private var pagingTabView: some View {
        PagingTabView(offset: $viewModel.offset, index: $viewModel.index, viewSize: viewSize, horizontal: horizontal) {
            content
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewSize: .init(width: 300, height: 200))
    }
}
