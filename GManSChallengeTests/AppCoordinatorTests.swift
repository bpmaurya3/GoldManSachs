//
//  AppCoordinatorTests.swift
//  GManSChallengeTests
//
//  Created by Bhuvanendra Pratap Maurya on 04/09/22.
//

import XCTest
@testable import GManSChallenge

class AppCoordinatorTests: XCTestCase {

    private var flowCoordinator: AppCoordinator!
    private var mockNavigationController: UINavigationController! = UINavigationController()
    private var mockFlowViewController: MockFlowViewController! = MockFlowViewController()

    private var mockViewController: UIViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        flowCoordinator = AppCoordinator(flowNavigationController: mockNavigationController)

    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        flowCoordinator = nil
        mockNavigationController = nil
        mockViewController = nil
    }

    func testStartFlowForSuccessfulPictureListPresentation() {

        // Given
        _ = mockFlowViewController.makePictureListViewController()

        // When
        flowCoordinator.start()

        // Then
        XCTAssertEqual(mockFlowViewController.events, [.makePictureListViewController])
    }

    func testStartFlowForSuccessfulPictureDetailsPresentation() {

        // Given
        guard let planet = PlanetDao().getPlanetFrom(imageUrl: "") else {
            return
        }
        let cellModel = PlanetCellModel(from: planet)
        _ = mockFlowViewController.makePictureListViewController()
        _ = mockFlowViewController.makePictureDetailspViewController(cellModel: cellModel)

        // When
        flowCoordinator.start()

        // Then
        XCTAssertEqual(mockFlowViewController.events, [.makePictureListViewController, .makePictureDetailspViewController])
    }

}

private class MockFlowViewController {
    enum Event: Equatable {
        case makePictureListViewController
        case makePictureDetailspViewController
    }

    private(set) var events: [Event] = []

    var viewControllerToReturn: UIViewController?

    func makePictureListViewController() -> UIViewController {
        events.append(.makePictureListViewController)

        return viewControllerToReturn ?? UIViewController()
    }

    func makePictureDetailspViewController(cellModel: PlanetCellModel) -> UIViewController {
        events.append(.makePictureDetailspViewController)
        return viewControllerToReturn ?? UIViewController()
    }
}
