//
//  ShapeView.swift
//  GemoetricShapes
//
//  Created by Gabriel Monteiro Camargo da Silva - GCM on 25/05/20.
//  Copyright © 2020 Gabriel Monteiro Camargo da Silva - GCM. All rights reserved.
//

import UIKit

class ShapeView: UIView {
    var type: GeometricType = .square
    private var dBPatch: UIBezierPath
    private var drect: CGRect
    
    enum GeometricType {
        case square
        case circle
        case triangle
    }
    
    override init(frame: CGRect) {
        drect = CGRect(x: 0, y: 0, width: 0, height: 0)
        dBPatch = UIBezierPath(rect: drect)
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let h = rect.height
        let w = rect.width
        let color: UIColor = .yellow
        
        switch type {
        case .square:
            drect = CGRect(x: 1, y: 1, width: w - 2, height: h - 2)
            dBPatch = UIBezierPath(rect: drect)
        case .circle:
            drect = CGRect(x: 1, y: 1, width: w - 2, height: h - 2)
            dBPatch = UIBezierPath(ovalIn: drect)
        case .triangle:
            dBPatch.move(to: CGPoint(x: 0 , y: h - 1))
            dBPatch.addLine(to: CGPoint(x: w / 2, y: 0))
            dBPatch.addLine(to: CGPoint(x: w, y: h - 1))
            dBPatch.close()
        }
        
        color.set()
        dBPatch.lineWidth = 2
        dBPatch.stroke()
    }
}
