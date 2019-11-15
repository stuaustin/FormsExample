//
//  RegisterViewController.swift
//  FormsExample
//
//  Created by Stuart Austin on 08/11/2019.
//  Copyright © 2019 Stuart Austin. All rights reserved.
//

import UIKit

final class RegisterViewController: UIViewController {

    let viewModel: RegisterViewModel

    private lazy var registerView = RegisterView(frame: UIScreen.main.bounds)

    // MARK: - Notifications

    private let keyboardHandler = ScrollViewKeyboardHandler()

    // MARK: - Initialization

    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
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

        registerView.firstNameItem.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        registerView.lastNameItem.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        registerView.emailItem.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        registerView.passwordItem.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)

        registerView.termsItem.addTarget(self, action: #selector(checkboxItemValueChanged(sender:)), for: .valueChanged)
        registerView.privacyItem.addTarget(self, action: #selector(checkboxItemValueChanged(sender:)), for: .valueChanged)

        registerView.createAccountButton.isEnabled = viewModel.isRegisterButtonEnabled
    }
}

// MARK: - UIControl events

extension RegisterViewController {
    @objc private func textFieldEditingChanged(sender: UITextField) {
        if sender === registerView.firstNameItem.textField {
            viewModel.formInformation.firstName = sender.text ?? ""
        } else if sender === registerView.lastNameItem.textField {
            viewModel.formInformation.lastName = sender.text ?? ""
        } else if sender === registerView.emailItem.textField {
            viewModel.formInformation.email = sender.text ?? ""
        } else if sender === registerView.passwordItem.textField {
            viewModel.formInformation.password = sender.text ?? ""
        }
    }

    @objc private func checkboxItemValueChanged(sender: CheckboxItemView) {
        if sender == registerView.termsItem {
            viewModel.formInformation.acceptTerms = sender.isSelected
        } else if sender == registerView.privacyItem {
            viewModel.formInformation.acceptPrivacy = sender.isSelected
        }
    }
}

// MARK: - RegisterViewModelDelegate

extension RegisterViewController: RegisterViewModelDelegate {
    func isRegisterButtonEnabledDidChange() {
        registerView.createAccountButton.isEnabled = viewModel.isRegisterButtonEnabled
    }
}
