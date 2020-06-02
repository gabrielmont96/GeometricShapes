//
//  ViewController.swift
//  GemoetricShapes
//
//  Created by Gabriel Monteiro Camargo da Silva - GCM on 25/05/20.
//  Copyright © 2020 Gabriel Monteiro Camargo da Silva - GCM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var square: UIButton!
    @IBOutlet weak var circle: UIButton!
    @IBOutlet weak var triangle: UIButton!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var slider: UISlider!
    
    var geometricShapesList: [ShapeView] = []
    var geometricShapesUndo: [ShapeView] = []
    var lastFormTapped: ShapeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addShape(_ sender: UIButton) {
        let shape = ShapeView(frame: CGRect(x: 5, y: 5, width: 40, height: 40))
        
        switch sender {
        case square:
            shape.type = .square
        case circle:
            shape.type = .circle
        case triangle:
            shape.type = .triangle
        default: break
        }
        
        shape.backgroundColor = UIColor(white: 1, alpha: 0)
        
        geometricShapesList.append(shape)
        geometricShapesUndo.removeAll()
        
        slider.value = 1
        
        shape.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
        
        baseView.addSubview(shape)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        guard let shapeSelected = gesture.view as? ShapeView else { return }
        
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: baseView)
            shapeSelected.center.x += translation.x
            shapeSelected.center.y += translation.y
            gesture.setTranslation(.zero, in: shapeSelected)
        case .ended:
            lastFormTapped = shapeSelected
            slider.value = Float(lastFormTapped?.transform.a ?? 1)
        default: break
        }
    }
    
    @IBAction func undoTapped(_ sender: Any) {
        guard geometricShapesList.count > 0 else { return }
        let lastShape = geometricShapesList.removeLast()
        lastShape.removeFromSuperview()
        geometricShapesUndo.append(lastShape)
    }
    
    @IBAction func redoTapped(_ sender: Any) {
        guard geometricShapesUndo.count > 0 else { return }
        let lastShape = geometricShapesUndo.removeLast()
        geometricShapesList.append(lastShape)
        baseView.addSubview(lastShape)
    }
    
    @IBAction func sliderTapped(_ sender: UISlider) {
        lastFormTapped?.transform = CGAffineTransform(scaleX: CGFloat(sender.value), y: CGFloat(sender.value))
    }
}

