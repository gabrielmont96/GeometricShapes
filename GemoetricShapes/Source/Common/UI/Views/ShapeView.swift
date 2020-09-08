//
//  ShapeView.swift
//  GemoetricShapes
//
//  Created by Gabriel Monteiro Camargo da Silva - GCM on 25/05/20.
//  Copyright © 2020 Gabriel Monteiro Camargo da Silva - GCM. All rights reserved.
//

import UIKit

class ShapeView: UIView {
    var shape: ShapeProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        shape?.draw(self.frame)
    }
}
