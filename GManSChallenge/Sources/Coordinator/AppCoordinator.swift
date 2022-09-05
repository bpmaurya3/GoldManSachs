//
//  AppCoordinator.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import UIKit

protocol Coordinator {
    var flowNavigationController: UINavigationController { get }
    func start()
}

/// AppCoordinator is the only coordiantor who is responsible for managing the controllers
class AppCoordinator: Coordinator {

    // MARK: - Properties
    var flowNavigationController: UINavigationController
    private lazy var planetManager = PlanetManager()

    // MARK: - Constructor

    init(flowNavigationController: UINavigationController = UINavigationController()) {
        self.flowNavigationController = flowNavigationController
    }

    var rootViewController: UIViewController {
        flowNavigationController
    }
    
    // MARK: - start

    func start() {
        showPlanetList()
    }

    /// Display the AccountDetialsViewController which is the first level for the app.
    private func showPlanetList() {
        // Initialize View Controller
        let viewModel = PictureListViewModel(planetManager: self.planetManager)
        viewModel.openDetails = { [weak self] model in
            self?.openPictureDetails(detailModel: model)
        }
        // Push Account Details View Controller Onto the Navigation Stack
        let viewController = Storyboardable<PictureListViewController>.main.instantiate
        viewController.viewModel = viewModel
        self.flowNavigationController.pushViewController(viewController, animated: true)
    }

    private func openPictureDetails(detailModel: PlanetCellModel) {
        // Initialize View Controller
        let viewModel = PictureDetailsViewModel(detailModel: detailModel)
        // Push Account Details View Controller Onto the Navigation Stack
        let viewController = Storyboardable<PictureDetailsViewController>.main.instantiate
        viewController.viewModel = viewModel
        self.flowNavigationController.pushViewController(viewController, animated: true)
    }
}
