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
    @IBOutlet weak var image: UIButton!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var slider: UISlider!
    
    let presenter = GeometricShapePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        guard let shapeSelected = gesture.view else { return }
        
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
    
    @IBAction func addShape(_ sender: UIButton) {
        let frame = CGRect(x: 5, y: 5, width: 40, height: 40)
        let shapeView = ShapeView(frame: frame)
        
        switch sender {
        case square:
            shapeView.shape = SquareView(frame: frame)
        case circle:
            shapeView.shape = CircleView(frame: frame)
        case triangle:
            shapeView.shape = TriangleView(frame: frame)
        case image:
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            DispatchQueue.main.async {
                self.present(imagePicker, animated: true, completion: nil)
            }
            return
        default: break
        }
        
        shapeView.backgroundColor = UIColor(white: 1, alpha: 0)
        
        slider.value = 1
        
        addView(view: shapeView)
    }
    
    func addView(view: UIView) {
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
        baseView.addSubview(view)
        presenter.addShapeInList(view)
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

extension GeometricShapeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[.originalImage] as? UIImage {
            let imageView = UIImageView(frame: .init(x: 5, y: 5, width: 40, height: 40))
            imageView.image = originalImage
            addView(view: imageView)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
