//
//  TriangleView.swift
//  GemoetricShapes
//
//  Created by Gabriel Monteiro Camargo da Silva - GCM on 03/09/20.
//  Copyright © 2020 Gabriel Monteiro Camargo da Silva - GCM. All rights reserved.
//

import UIKit

class TriangleView: ShapeProtocol {
    func draw(_ rect: CGRect) {
        let dBPatch = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 0, height: 0))

        let h = rect.height
        let w = rect.width
        let color: UIColor = .blue
        
        dBPatch.move(to: CGPoint(x: 0 , y: h - 1))
        dBPatch.addLine(to: CGPoint(x: w / 2, y: 0))
        dBPatch.addLine(to: CGPoint(x: w, y: h - 1))
        dBPatch.close()
        
        color.set()
        dBPatch.lineWidth = 2
        dBPatch.stroke()
    }
}
