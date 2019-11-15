//
//  CheckboxItemView.swift
//  FormsExample
//
//  Created by Stuart Austin on 08/11/2019.
//  Copyright © 2019 Stuart Austin. All rights reserved.
//

import UIKit

final class CheckboxItemView: UIControl {

    let outerBoxView: UIView = {
        let outerView = UIView()
        outerView.backgroundColor = UIColor.groupTableViewBackground
        return outerView
    }()

    let innerBoxView: UIView = {
        let innerBoxView = UIView()
        innerBoxView.backgroundColor = innerBoxView.tintColor
        return innerBoxView
    }()

    let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        return textLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    private func setUp() {
        addSubview(outerBoxView)
        outerBoxView.translatesAutoresizingMaskIntoConstraints = false
        outerBoxView.layer.cornerRadius = 15.0

        outerBoxView.addSubview(innerBoxView)
        innerBoxView.translatesAutoresizingMaskIntoConstraints = false
        innerBoxView.layer.cornerRadius = 10.0

        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            outerBoxView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0),
            outerBoxView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            outerBoxView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            outerBoxView.centerYAnchor.constraint(equalTo: centerYAnchor),

            outerBoxView.widthAnchor.constraint(equalToConstant: 30.0),
            outerBoxView.heightAnchor.constraint(equalToConstant: 30.0),

            innerBoxView.widthAnchor.constraint(equalToConstant: 20.0),
            innerBoxView.heightAnchor.constraint(equalToConstant: 20.0),

            innerBoxView.centerXAnchor.constraint(equalTo: outerBoxView.centerXAnchor),
            innerBoxView.centerYAnchor.constraint(equalTo: outerBoxView.centerYAnchor),

            textLabel.leadingAnchor.constraint(equalTo: outerBoxView.trailingAnchor, constant: 5),
            textLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 5),
            textLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -5),
            textLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
            ])

        isSelectedDidChange()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isSelected.toggle()
        sendActions(for: .valueChanged)
    }

    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            super.isSelected = newValue
            isSelectedDidChange()
        }
    }

    private func isSelectedDidChange() {
        innerBoxView.isHidden = !isSelected
    }
}
