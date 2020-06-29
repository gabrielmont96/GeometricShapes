//
//  ViewController.swift
//  GemoetricShapes
//
//  Created by Gabriel Monteiro Camargo da Silva - GCM on 25/05/20.
//  Copyright © 2020 Gabriel Monteiro Camargo da Silva - GCM. All rights reserved.
//

import UIKit

class GeometricShapeViewController: UIViewController {
    @IBOutlet weak var square: UIButton!
    @IBOutlet weak var circle: UIButton!
    @IBOutlet weak var triangle: UIButton!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var slider: UISlider!
    
    let presenter = GeometricShapePresenter()
    
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
        
        slider.value = 1
        
        shape.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
        
        baseView.addSubview(shape)
        presenter.addShapeInList(shape)
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
            slider.value = Float(shapeSelected.transform.a)
            presenter.lastShapeMoved = shapeSelected
        default: break
        }
    }
    
    @IBAction func undoTapped(_ sender: Any) {
        presenter.removeShapeFromList()?.removeFromSuperview()
    }
    
    @IBAction func redoTapped(_ sender: Any) {
        guard let shape = presenter.removeShapeFromUndoList() else { return }
        baseView.addSubview(shape)
    }
    
    @IBAction func sliderTapped(_ sender: UISlider) {
        presenter.lastShapeMoved?.transform = CGAffineTransform(scaleX: CGFloat(sender.value), y: CGFloat(sender.value))
    }
    
    @IBAction func screenshotTapped(_ sender: Any) {
        guard presenter.haveShapesInList else {
            let alert = UIAlertController(title: "Aviso",
                                          message: "Você ainda não adicionou nenhuma forma geométrica!",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Entendi", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let image = baseView.takeScreenShot() else { return }
        let vc = ScreenShotViewController(image: image)
        self.present(vc, animated: true, completion: nil)
    }
}
