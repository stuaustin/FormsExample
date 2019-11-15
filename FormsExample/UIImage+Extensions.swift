//
//  UIImage+Extensions.swift
//  FormsExample
//
//  Created by Stuart Austin on 08/11/2019.
//  Copyright © 2019 Stuart Austin. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init(color: UIColor) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))

        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))

        let image = UIGraphicsGetImageFromCurrentImageContext()!

        UIGraphicsEndImageContext()

        self.init(cgImage: image.cgImage!)
    }
}
