# PagingTabView
It seems that Apple's TabView took some steroids! 💊

## Setup

Add the following to `Package.swift`:

```swift
.package(url: "https://github.com/stateman92/PagingTabView", exact: .init(0, 0, 5))
```

[Or add the package in Xcode.](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

## Usage

```swift
@ObservedObject private var viewModel: PagingTabViewViewModel
// ...
VStack {
    SegmentedControl(items: ["Gray", "Green", "Red", "Blue", "Brown"], selectedSegmentIndex: $viewModel.segmentIndex)
    PagingTabView(offset: $viewModel.offset, index: $viewModel.index, viewSize: viewSize, horizontal: horizontal) {
        ForEach(0...4, id: \.self) { index in
            Image(systemName: "circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.red)
        }
    }
}
```

For details see the Example app.

## Example

<p style="text-align:center;"><img src="https://github.com/stateman92/PagingTabView/blob/main/Resources/screenrecording.gif?raw=true" width="50%" alt="Example"></p>
