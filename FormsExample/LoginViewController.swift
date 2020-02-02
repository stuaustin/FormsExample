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
import RxSwift
import RxCocoa

protocol LoginViewControllerDelegate: class {
    func showRegisterController()
}

final class LoginViewController: UIViewController {

    private lazy var loginView = LoginView(frame: UIScreen.main.bounds)

    private let viewModel: LoginViewModel

    weak var delegate: LoginViewControllerDelegate?

    private let disposeBag = DisposeBag()

    // MARK: - Notifications

    private let keyboardHandler = ScrollViewKeyboardHandler()

    // MARK: - Initialization

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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

        loginView.createAccountButton.addTarget(self, action: #selector(registerButtonWasPressed), for: .touchUpInside)

        bindUI()
    }

    private func bindUI() {
        disposeBag.insert(
            // Bind the ViewModel state to the UI
            viewModel.email.bind(to: loginView.emailItem.textField.rx.text),
            viewModel.password.bind(to: loginView.passwordItem.textField.rx.text),
            viewModel.rememberEmail.bind(to: loginView.rememberItem.rx.isSelected),
            viewModel.isLoginButtonEnabled.drive(loginView.loginButton.rx.isEnabled),

            // Bind the UI to the ViewModel
            loginView.emailItem.textField.rx.text.orEmpty.bind(to: viewModel.email),
            loginView.passwordItem.textField.rx.text.orEmpty.bind(to: viewModel.password),
            loginView.rememberItem.rx.controlEvent(.valueChanged).map { [unowned rememberItem = loginView.rememberItem] in
                rememberItem.isSelected
            }.bind(to: viewModel.rememberEmail)
        )
    }

    // MARK: - Button Actions

    @objc private func registerButtonWasPressed() {
        delegate?.showRegisterController()
    }
}
