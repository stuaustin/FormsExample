//
//  ScrollViewKeyboardHandler.swift
//  ComponentUI
//
//  Created by Stuart Austin on 08/11/2019.
//  Copyright © 2019 Stuart Austin. All rights reserved.
//

import UIKit

final class ScrollViewKeyboardHandler {
    weak var scrollView: UIScrollView? = nil

    init() {
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillChangeFrame(notification:)),
                           name: UIResponder.keyboardWillChangeFrameNotification,
                           object: nil)
    }

    private var contentInsetAdjustment: CGFloat = 0
    private var scrollIndicatorInsetAdjustment: CGFloat = 0

    @objc private func keyboardWillChangeFrame(notification: Notification) {
        guard let scrollView = self.scrollView, let superview = scrollView.superview, let window = scrollView.window else { return }
        guard let endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        let endFrameInSuperview: CGRect = window.convert(endFrame, to: superview)
        let keyboardCoveringScrollView: CGFloat = max(0, scrollView.frame.maxY - endFrameInSuperview.minY)

        var newContentInsets = scrollView.contentInset
        newContentInsets.bottom -= contentInsetAdjustment
        contentInsetAdjustment = keyboardCoveringScrollView
        newContentInsets.bottom += contentInsetAdjustment

        scrollView.contentInset = newContentInsets

        var newScrollIndicatorInsets = scrollView.scrollIndicatorInsets
        newScrollIndicatorInsets.bottom -= scrollIndicatorInsetAdjustment
        scrollIndicatorInsetAdjustment = keyboardCoveringScrollView
        newScrollIndicatorInsets.bottom += scrollIndicatorInsetAdjustment

        scrollView.scrollIndicatorInsets = newScrollIndicatorInsets
    }
}
