//
//  VideoRouterTests.swift
//  FlowTests
//
//  Created by Pedro Sousa on 02/09/23.
//

import XCTest
@testable import SampleApp

final class VideoRouterTests: XCTestCase {
    var sut: VideoRouter!
    var parent: DashboardCoordinator!

    override func setUp() {
        parent = DashboardCoordinator()
        sut = VideoRouter(parent: parent)
    }

    override func tearDown() {
        parent = nil
        sut = nil
    }

    func test_videoRouter_push() {
        sut.push(1)

        XCTAssertTrue(parent.breadcrumbs.contains(where: { $0.hashValue == 1.hashValue }))
        XCTAssertEqual(parent.breadcrumbs.count, 1)
    }

    func test_videoRouter_pop() {
        sut.push(1)

        sut.pop()

        XCTAssertTrue(parent.breadcrumbs.isEmpty)
    }

    func test_videoRouter_popTo() {
        sut.push(1)
        sut.push(2)
        sut.push(3)

        sut.pop(to: 2)

        XCTAssertEqual(parent.breadcrumbs.count, 2)
    }

    func test_videoRouter_popToRoot() {
        sut.push(1)
        sut.push(2)
        sut.push(3)

        sut.popToRoot()

        XCTAssertTrue(parent.breadcrumbs.isEmpty)
    }
}
