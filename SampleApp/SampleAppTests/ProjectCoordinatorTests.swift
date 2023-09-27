//
//  ProjectCoordinatorTests.swift
//  FlowTests
//
//  Created by Pedro Sousa on 02/09/23.
//

import XCTest
@testable import SampleApp

final class ProjectCoordinatorTests: XCTestCase {
    var sut: ProjectCoordinator!

    override func setUp() {
        sut = ProjectCoordinator()
    }

    override func tearDown() {
        sut = nil
    }

    func test_projectCoordinator_dismiss() {
        var didDismiss = false
        sut.onDismiss {
            didDismiss = true
        }

        sut.dismiss()

        XCTAssertTrue(didDismiss)
    }
}
