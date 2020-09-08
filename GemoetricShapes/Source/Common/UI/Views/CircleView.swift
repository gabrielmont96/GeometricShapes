//
//  CircleView.swift
//  GemoetricShapes
//
//  Created by Gabriel Monteiro Camargo da Silva - GCM on 03/09/20.
//  Copyright © 2020 Gabriel Monteiro Camargo da Silva - GCM. All rights reserved.
//

import UIKit

class CircleView: ShapeProtocol {
    func draw(_ rect: CGRect) {
        let h = rect.height
        let w = rect.width
        let color: UIColor = .yellow
        
        let drect = CGRect(x: 1, y: 1, width: w - 2, height: h - 2)
        let dBPatch = UIBezierPath(ovalIn: drect)
        
        color.set()
        dBPatch.lineWidth = 2
        dBPatch.stroke()
    }
}
