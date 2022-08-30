//
//  File.swift
//  
//
//  Created by Kristof Kalai on 2022. 08. 30..
//

import Combine
import SwiftUI

public final class PagingTabViewViewModel: ObservableObject {
    @Published public var offset: CGFloat = .zero
    @Published public var index: Int = .zero
    @Published public var segmentIndex: Int = .zero

    private let viewSize: CGSize
    private let horizontal: Bool
    private var cancellables = Set<AnyCancellable>()

    public init(viewSize: CGSize, horizontal: Bool) {
        self.viewSize = viewSize
        self.horizontal = horizontal
        setupBindings()
    }
}

extension PagingTabViewViewModel {
    private var size: CGFloat {
        horizontal ? viewSize.width : viewSize.height
    }

    private func setupBindings() {
        $segmentIndex
            .sink { [unowned self] in set(index: $0) }
            .store(in: &cancellables)
        $index
            .sink { [unowned self] in segmentIndex = $0 }
            .store(in: &cancellables)
    }
}

extension PagingTabViewViewModel {
    public func set(index: Int) {
        offset = CGFloat(index) * size
    }

    public var currentIndex: Int {
        Int(round(offset / size))
    }
}
