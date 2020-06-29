//
//  ScreenShotViewController.swift
//  GemoetricShapes
//
//  Created by Gabriel Monteiro Camargo da Silva - GCM on 27/06/20.
//  Copyright © 2020 Gabriel Monteiro Camargo da Silva - GCM. All rights reserved.
//

import UIKit

class ScreenShotViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    let image: UIImage!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    
    @IBAction func shareTapped(_ sender: Any) {
        let share = [image]
        let activityViewC = UIActivityViewController(activityItems: share, applicationActivities: nil)
        self.present(activityViewC, animated: true, completion: nil)
    }
}
