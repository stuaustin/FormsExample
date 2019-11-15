//
//  RootCoordinator.swift
//  FormsExample
//
//  Created by Stuart Austin on 08/11/2019.
//  Copyright © 2019 Stuart Austin. All rights reserved.
//

import UIKit

final class RootCoordinator: LoginViewControllerDelegate {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.setViewControllers([createLoginController()], animated: false)
    }

    func showRegisterController() {
        if let index = navigationController.viewControllers.firstIndex(where: { $0 is RegisterViewController }) {
            navigationController.setViewControllers(Array(navigationController.viewControllers[0...index]), animated: true)
        } else {
            navigationController.pushViewController(createRegisterController(), animated: true)
        }
    }

    private func createLoginController() -> UIViewController {
        let viewModel = LoginViewModel()
        let controller = LoginViewController(viewModel: viewModel)
        controller.delegate = self
        return controller
    }

    private func createRegisterController() -> UIViewController {
        let viewModel = RegisterViewModel()
        let controller = RegisterViewController(viewModel: viewModel)
        return controller
    }
}
