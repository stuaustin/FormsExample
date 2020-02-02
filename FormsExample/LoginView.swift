//
//  LoginView.swift
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

final class LoginView: UIView {

    // MARK: - Constants

    enum Constants {
        static let cornerRadius: CGFloat = 5
        static let contentSpacing: CGFloat = 25
        static let buttonHeight: CGFloat = 50
        static let horizontalEdgeSpacing: CGFloat = 10
        static let verticalEdgeSpacing: CGFloat = 25
    }

    // MARK: - Subviews

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .always
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()

    let contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill
        contentStackView.spacing = Constants.contentSpacing
        return contentStackView
    }()

    let infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.font = UIFont.preferredFont(forTextStyle: .body)
        infoLabel.text = "Please log in using your email or your existing account credentials."
        infoLabel.numberOfLines = 0
        return infoLabel
    }()

    let emailItem: FormItemView = {
        let emailItem = FormItemView()
        emailItem.headerLabel.text = "Email"
        emailItem.textField.keyboardType = .emailAddress
        emailItem.textField.autocapitalizationType = .none
        emailItem.textField.textContentType = .username
        return emailItem
    }()

    let passwordItem: FormItemView = {
        let passwordItem = FormItemView()
        passwordItem.headerLabel.text = "Password"
        passwordItem.textField.isSecureTextEntry = true
        passwordItem.textField.textContentType = .password
        return passwordItem
    }()

    let rememberItem: CheckboxItemView = {
        let rememberItem = CheckboxItemView()
        rememberItem.textLabel.text = "Remember my email address"
        return rememberItem
    }()

    let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setBackgroundImage(UIImage(color: loginButton.tintColor), for: .normal)
        loginButton.layer.cornerRadius = Constants.cornerRadius
        loginButton.clipsToBounds = true
        return loginButton
    }()

    let createAccountButton: UIButton = {
        let createAccountButton = UIButton()
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setBackgroundImage(UIImage(color: .darkGray), for: .normal)
        createAccountButton.layer.cornerRadius = Constants.cornerRadius
        createAccountButton.clipsToBounds = true
        return createAccountButton
    }()

    let copyrightLabel: UILabel = {
        let copyrightLabel = UILabel()
        copyrightLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        copyrightLabel.text = "Copyright 2019 Some Company Ltd"
        return copyrightLabel
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpSubviews()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .white
        setUpSubviews()
        setUpConstraints()
    }

    private func setUpSubviews() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        contentStackView.addArrangedSubview(infoLabel)
        contentStackView.addArrangedSubview(emailItem)
        contentStackView.addArrangedSubview(passwordItem)
        contentStackView.addArrangedSubview(rememberItem)
        contentStackView.addArrangedSubview(loginButton)
        contentStackView.addArrangedSubview(createAccountButton)
        contentStackView.addArrangedSubview(copyrightLabel)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Constants.horizontalEdgeSpacing * 2),

            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.verticalEdgeSpacing),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.verticalEdgeSpacing),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.horizontalEdgeSpacing),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Constants.horizontalEdgeSpacing),

            loginButton.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.buttonHeight),
            createAccountButton.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.buttonHeight)
            ])
    }
}
