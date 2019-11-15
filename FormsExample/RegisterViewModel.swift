//
//  RegisterViewModel.swift
//  FormsExample
//
//  Created by Stuart Austin on 08/11/2019.
//  Copyright © 2019 Stuart Austin. All rights reserved.
//

import Foundation

struct RegisterInformation {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""

    var acceptTerms: Bool = false
    var acceptPrivacy: Bool = false
}

protocol RegisterViewModelDelegate: class {
    func isRegisterButtonEnabledDidChange()
}

final class RegisterViewModel {

    weak var delegate: RegisterViewModelDelegate?

    var formInformation = RegisterInformation() {
        didSet {
            isRegisterButtonEnabled = determineRegisterButtonEnabled()
        }
    }

    private func determineRegisterButtonEnabled() -> Bool {
        guard !formInformation.firstName.isEmpty && !formInformation.lastName.isEmpty && !formInformation.password.isEmpty else {
            return false
        }
        guard formInformation.acceptTerms && formInformation.acceptPrivacy else {
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

    private (set) var isRegisterButtonEnabled: Bool = false {
        didSet {
            if oldValue != isRegisterButtonEnabled {
                delegate?.isRegisterButtonEnabledDidChange()
            }
        }
    }

    private let emailRegexPattern: String = #"""
    (?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])
    """#

}
