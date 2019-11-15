//
//  LayerView.swift
//  FormsExample
//
//  Created by Stuart Austin on 08/11/2019.
//  Copyright © 2019 Stuart Austin. All rights reserved.
//

import UIKit

final class LayerView<LayerClass: CALayer>: UIView {
    override class var layerClass: AnyClass {
        return LayerClass.self
    }

    var customLayer: LayerClass {
        return layer as! LayerClass
    }
}
