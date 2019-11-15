//
//  FormItemView.swift
//  FormsExample
//
//  Created by Stuart Austin on 08/11/2019.
//  Copyright © 2019 Stuart Austin. All rights reserved.
//

import UIKit

final class FormItemView: UIView {
    let headerLabel = UILabel()
    let textField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    private func setUp() {
        addSubview(headerLabel)
        headerLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        headerLabel.numberOfLines = 0
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(textField)
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.groupTableViewBackground
        textField.layer.cornerRadius = 5.0

        let textFieldHeightConstraint = textField.heightAnchor.constraint(equalToConstant: 45)
        textFieldHeightConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),

            textField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textFieldHeightConstraint
            ])
    }
}
