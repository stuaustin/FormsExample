//
//  LoginViewModel.swift
//  FormsExample
//
//  Created by Stuart Austin on 08/11/2019.
//  Copyright © 2019 Stuart Austin. All rights reserved.
//

import UIKit

struct LoginInformation {
    var email: String = ""
    var password: String = ""
    var rememberEmail: Bool = false
}

protocol LoginViewModelDelegate: class {
    func isLoginButtonEnabledDidChange()
}

final class LoginViewModel {

    weak var delegate: LoginViewModelDelegate?

    var formInformation = LoginInformation() {
        didSet {
            isLoginButtonEnabled = determineLoginButtonEnabled()
        }
    }

    private func determineLoginButtonEnabled() -> Bool {
        guard !formInformation.password.isEmpty else {
            return false
        }

        let emailRegex: NSRegularExpression = try! NSRegularExpression(pattern: emailRegexPattern,
                                                                       options: [])
        let emailMatch: NSTextCheckingResult? = emailRegex.firstMatch(in: formInformation.email,
                                                                      options: [],
                                                                      range: NSRange(location: 0, length: (formInformation.email as NSString).length))
        guard emailMatch != nil else {
            return false
        }

        return true
    }

    private (set) var isLoginButtonEnabled: Bool = false {
        didSet {
            if oldValue != isLoginButtonEnabled {
                delegate?.isLoginButtonEnabledDidChange()
            }
        }
    }

    private let emailRegexPattern: String = #"""
    (?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])
    """#
}
