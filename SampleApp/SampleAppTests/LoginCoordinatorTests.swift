//
//  LoginCoordinatorTests.swift
//  FlowTests
//
//  Created by Pedro Sousa on 01/09/23.
//

import XCTest
@testable import SampleApp

final class LoginCoordinatorTests: XCTestCase {
    var sut: LoginCoordinator!
    
    override func setUp() {
        sut = LoginCoordinator(path: .init(), onDismiss: nil)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_loginCoordinator_dismiss() {
        var didDismiss = false
        let sut = LoginCoordinator(path: .init()) {
            didDismiss = true
        }

        sut.dismiss()

        XCTAssertTrue(didDismiss)
    }
}
