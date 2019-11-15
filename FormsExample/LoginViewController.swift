//
//  LoginViewController.swift
//  FormsExample
//
//  Created by Stuart Austin on 08/11/2019.
//  Copyright © 2019 Stuart Austin. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func showRegisterController()
}

final class LoginViewController: UIViewController {

    private lazy var loginView = LoginView(frame: UIScreen.main.bounds)

    private let viewModel: LoginViewModel

    weak var delegate: LoginViewControllerDelegate?

    // MARK: - Notifications

    private let keyboardHandler = ScrollViewKeyboardHandler()

    // MARK: - Initialization

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Login"
        keyboardHandler.scrollView = loginView.scrollView

        loginView.emailItem.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        loginView.passwordItem.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        loginView.rememberItem.addTarget(self, action: #selector(rememberItemValueChanged(sender:)), for: .valueChanged)

        loginView.loginButton.isEnabled = viewModel.isLoginButtonEnabled
        loginView.createAccountButton.addTarget(self, action: #selector(registerButtonWasPressed), for: .touchUpInside)
    }

    // MARK: - Button Actions

    @objc private func registerButtonWasPressed() {
        delegate?.showRegisterController()
    }
}

// MARK: - UIControl events

extension LoginViewController {
    @objc private func textFieldEditingChanged(sender: UITextField) {
        if sender === loginView.emailItem.textField {
            viewModel.formInformation.email = sender.text ?? ""
        } else if sender === loginView.passwordItem.textField {
            viewModel.formInformation.password = sender.text ?? ""
        }
    }

    @objc private func rememberItemValueChanged(sender: CheckboxItemView) {
        viewModel.formInformation.rememberEmail = sender.isSelected
    }
}

// MARK: - LoginViewModelDelegate

extension LoginViewController: LoginViewModelDelegate {
    func isLoginButtonEnabledDidChange() {
        loginView.loginButton.isEnabled = viewModel.isLoginButtonEnabled
    }
}
