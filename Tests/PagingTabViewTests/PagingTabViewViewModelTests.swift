import XCTest
@testable import PagingTabView

final class PagingTabViewViewModelTests: XCTestCase {
    private let horizontalPagingTabViewViewModel = PagingTabViewViewModel(viewSize: .init(width: 200, height: 300),
                                                                          horizontal: true)
    private let verticalPagingTabViewViewModel = PagingTabViewViewModel(viewSize: .init(width: 200, height: 300),
                                                                        horizontal: false)
}

extension PagingTabViewViewModelTests {
    func testSetIndex() throws {
        XCTAssertEqual(horizontalPagingTabViewViewModel.currentIndex, 0)
        horizontalPagingTabViewViewModel.set(index: 1)
        XCTAssertEqual(horizontalPagingTabViewViewModel.currentIndex, 1)
    }

    func testSetIndexWithIndexProperty() throws {
        XCTAssertEqual(horizontalPagingTabViewViewModel.currentIndex, 0)
        horizontalPagingTabViewViewModel.index = 1
        XCTAssertEqual(horizontalPagingTabViewViewModel.currentIndex, 1)
    }

    func testSetIndexWithSegmentIndexProperty() throws {
        XCTAssertEqual(horizontalPagingTabViewViewModel.currentIndex, 0)
        horizontalPagingTabViewViewModel.segmentIndex = 1
        XCTAssertEqual(horizontalPagingTabViewViewModel.currentIndex, 1)
    }

    func testSetIndexWithOffsetHorizontally() throws {
        XCTAssertEqual(horizontalPagingTabViewViewModel.currentIndex, 0)
        horizontalPagingTabViewViewModel.offset = 200
        XCTAssertEqual(horizontalPagingTabViewViewModel.currentIndex, 1)
    }

    func testSetIndexWithOffsetVertically() throws {
        XCTAssertEqual(horizontalPagingTabViewViewModel.currentIndex, 0)
        verticalPagingTabViewViewModel.offset = 300
        XCTAssertEqual(verticalPagingTabViewViewModel.currentIndex, 1)
    }
}
