//
//  DashboardCoordinatorTests.swift
//  FlowTests
//
//  Created by Pedro Sousa on 01/09/23.
//

import XCTest
@testable import SampleApp

final class DashboardCoordinatorTests: XCTestCase {
    var sut: DashboardCoordinator!
    var spy: AppCoordinator!
    
    override func setUp() {
        spy = AppCoordinator()
        sut = DashboardCoordinator(appCoordinator: spy)
    }
    
    override func tearDown() {
        sut = nil
        spy = nil
    }

    func test_dashboardCoordiantor_present() {
        sut.present(sheet: .projectEditor)

        XCTAssertTrue(sut.isPresentingProjectEditor)
    }

    func test_dashboardCoordiantor_dismiss() {
        sut.present(sheet: .projectEditor)

        sut.dismiss(sheet: .projectEditor)

        XCTAssertFalse(sut.isPresentingProjectEditor)
    }

    func test_dashboardCoordinator_logOut() {
        sut.logOut()

        XCTAssertTrue(sut.appCoordinator!.shouldLogIn)
    }
}
