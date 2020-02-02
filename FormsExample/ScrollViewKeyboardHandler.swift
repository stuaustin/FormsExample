//
//  ScrollViewKeyboardHandler.swift
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
