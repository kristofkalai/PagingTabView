//
//  _PagingTabView.swift
//  
//
//  Created by Kristof Kalai on 2022. 08. 30..
//

import SwiftUI

struct _PagingTabView<Content: View> {
    @Binding var offset: CGFloat
    @Binding var index: Int
    let bounces: Bool
    let viewSize: CGSize
    let horizontal: Bool
    @ViewBuilder var content: () -> Content
}

extension _PagingTabView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = bounces
        scrollView.delegate = context.coordinator

        let hostView = UIHostingController(rootView: content())
        hostView.view.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(hostView.view)
        scrollView.addConstraints([
            hostView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])

        if horizontal {
            hostView.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        } else {
            hostView.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }

        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if horizontal {
            let currentOffset = uiView.contentOffset.x
            guard currentOffset != offset else { return }
            uiView.setContentOffset(.init(x: offset, y: .zero), animated: true)
        } else {
            let currentOffset = uiView.contentOffset.y
            guard currentOffset != offset else { return }
            uiView.setContentOffset(.init(x: .zero, y: offset), animated: true)
        }
    }
}

extension _PagingTabView {
    final class Coordinator: NSObject, UIScrollViewDelegate {
        private let parent: _PagingTabView

        init(parent: _PagingTabView) {
            self.parent = parent
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = parent.horizontal ? scrollView.contentOffset.x : scrollView.contentOffset.y
            parent.offset = offset
        }

        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            recalculateIndex(scrollView)
        }

        func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
            recalculateIndex(scrollView)
        }

        private func recalculateIndex(_ scrollView: UIScrollView) {
            DispatchQueue.main.async { [self] in
                let offset = parent.horizontal ? scrollView.contentOffset.x : scrollView.contentOffset.y
                parent.index = Int(offset / (parent.horizontal ? parent.viewSize.width : parent.viewSize.height))
            }
        }
    }
}
