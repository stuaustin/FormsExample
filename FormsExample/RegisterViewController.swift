//
//  RegisterViewController.swift
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

final class RegisterViewController: UIViewController {

    let viewModel: RegisterViewModel

    private lazy var registerView = RegisterView(frame: UIScreen.main.bounds)

    private let disposeBag = DisposeBag()

    // MARK: - Notifications

    private let keyboardHandler = ScrollViewKeyboardHandler()

    // MARK: - Initialization

    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle

    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Account"
        keyboardHandler.scrollView = registerView.scrollView

        bindUI()
    }

    private func bindUI() {
        disposeBag.insert(
            // Bind the ViewModel state to the UI
            viewModel.firstName.bind(to: registerView.firstNameItem.textField.rx.text),
            viewModel.lastName.bind(to: registerView.lastNameItem.textField.rx.text),
            viewModel.email.bind(to: registerView.emailItem.textField.rx.text),
            viewModel.password.bind(to: registerView.passwordItem.textField.rx.text),
            viewModel.acceptTerms.bind(to: registerView.termsItem.rx.isSelected),
            viewModel.acceptPrivacy.bind(to: registerView.privacyItem.rx.isSelected),
            viewModel.isRegisterButtonEnabled.drive(registerView.createAccountButton.rx.isEnabled),

            // Bind the UI to the ViewModel
            registerView.firstNameItem.textField.rx.text.orEmpty.bind(to: viewModel.firstName),
            registerView.lastNameItem.textField.rx.text.orEmpty.bind(to: viewModel.lastName),
            registerView.emailItem.textField.rx.text.orEmpty.bind(to: viewModel.email),
            registerView.passwordItem.textField.rx.text.orEmpty.bind(to: viewModel.password),
            registerView.termsItem.rx.controlEvent(.valueChanged).map { [unowned termsItem = registerView.termsItem] in
                termsItem.isSelected
            }.bind(to: viewModel.acceptTerms),
            registerView.privacyItem.rx.controlEvent(.valueChanged).map { [unowned privacyItem = registerView.privacyItem] in
                privacyItem.isSelected
            }.bind(to: viewModel.acceptPrivacy)
        )
    }
}
