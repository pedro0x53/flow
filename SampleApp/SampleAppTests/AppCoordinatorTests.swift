//
//  AppCoordinatorTests.swift
//  FlowTests
//
//  Created by Pedro Sousa on 01/09/23.
//

import XCTest
@testable import SampleApp

final class AppCoordinatorTests: XCTestCase {
    var sut: AppCoordinator!
    
    override func setUp() {
        sut = AppCoordinator()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_appCoordinator_init() {
        let sut = AppCoordinator(isLoggedIn: false, selectedTab: .dashboard)
       
        XCTAssertTrue(sut.shouldLogIn)
        XCTAssertEqual(sut.selectedTab, AppCoordinator.Tabs.dashboard)
    }

    func test_appCoordinator_logOut() {
        sut.logOut()

        XCTAssertTrue(sut.shouldLogIn)
    }

    func test_appCoordinator_selectTab() {
        sut.select(tab: .calendar)
        XCTAssertEqual(sut.selectedTab, AppCoordinator.Tabs.calendar)

        sut.select(tab: .settings)
        XCTAssertEqual(sut.selectedTab, AppCoordinator.Tabs.settings)

        sut.select(tab: .dashboard)
        XCTAssertEqual(sut.selectedTab, AppCoordinator.Tabs.dashboard)
    }

    func test_appCoordinator_present() {
        sut.present(sheet: .login)

        XCTAssertTrue(sut.shouldLogIn)
    }

    func test_appCoordinator_dismiss() {
        sut.present(sheet: .login)
        sut.dismiss(sheet: .login)

        XCTAssertFalse(sut.shouldLogIn)
    }
}
