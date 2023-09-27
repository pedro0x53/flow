//
//  LoginRouterTests.swift
//  FlowTests
//
//  Created by Pedro Sousa on 01/09/23.
//

import XCTest
@testable import SampleApp

final class LoginLoginCoordinatorTests: XCTestCase {
    var sut: LoginCoordinator!
    
    override func setUp() {
        sut = LoginCoordinator()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_loginCoordinator_dismiss() {
        var didDismiss = false
        let sut = LoginCoordinator {
            didDismiss = true
        }

        sut.dismiss()

        XCTAssertTrue(didDismiss)
    }

    func test_loginCoordinator_push() {
        let route = LoginCoordinator.Coordinates.forgetPassword
        sut.push(route)

        let index = sut.breadcrumbs.firstIndex(where: { $0.hashValue == route.hashValue })

        XCTAssertEqual(sut.breadcrumbs.count, 1)
        XCTAssertNotNil(index)
        XCTAssertEqual(index, 0)
    }

    func test_loginCoordinator_pop() {
        let route = LoginCoordinator.Coordinates.forgetPassword
        sut.push(route)

        sut.pop()

        XCTAssertEqual(sut.breadcrumbs.count, 0)
    }

    func test_loginCoordinator_popTo() {
        sut.push(1)
        sut.push(2)
        sut.push(3)

        sut.pop(to: 2)

        XCTAssertEqual(sut.breadcrumbs.count, 2)
    }

    func test_loginCoordinator_popToRoot() {
        sut.push(1)
        sut.push(2)
        sut.push(3)

        sut.popToRoot()

        XCTAssertEqual(sut.breadcrumbs.count, 0)
    }
}
