//
//  LoginViewController.swift
//
//  Copyright (c) 2019 Stuart Austin
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
