//
//  RegisterView.swift
//  FormsExample
//
//  Created by Stuart Austin on 08/11/2019.
//  Copyright © 2019 Stuart Austin. All rights reserved.
//

import UIKit

final class RegisterView: UIView {

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

    let firstNameItem: FormItemView = {
        let firstNameItem = FormItemView()
        firstNameItem.headerLabel.text = "First name"
        firstNameItem.textField.keyboardType = .alphabet
        firstNameItem.textField.textContentType = .givenName
        return firstNameItem
    }()

    let lastNameItem: FormItemView = {
        let lastNameItem = FormItemView()
        lastNameItem.headerLabel.text = "Last name"
        lastNameItem.textField.keyboardType = .alphabet
        lastNameItem.textField.textContentType = .familyName
        return lastNameItem
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
        passwordItem.textField.textContentType = .newPassword
        return passwordItem
    }()

    let termsItem: CheckboxItemView = {
        let termsItem = CheckboxItemView()
        termsItem.textLabel.text = "I accept the Terms & Conditions"
        return termsItem
    }()

    let privacyItem: CheckboxItemView = {
        let privacyItem = CheckboxItemView()
        privacyItem.textLabel.text = "I accept the Privacy & Cookie Policy"
        return privacyItem
    }()

    let createAccountButton: UIButton = {
        let createAccountButton = UIButton()
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setBackgroundImage(UIImage(color: createAccountButton.tintColor), for: .normal)
        createAccountButton.layer.cornerRadius = Constants.cornerRadius
        createAccountButton.clipsToBounds = true
        return createAccountButton
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

        contentStackView.addArrangedSubview(firstNameItem)
        contentStackView.addArrangedSubview(lastNameItem)
        contentStackView.addArrangedSubview(emailItem)
        contentStackView.addArrangedSubview(passwordItem)
        contentStackView.addArrangedSubview(termsItem)
        contentStackView.addArrangedSubview(privacyItem)
        contentStackView.addArrangedSubview(createAccountButton)
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

            createAccountButton.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.buttonHeight)
            ])
    }
}
