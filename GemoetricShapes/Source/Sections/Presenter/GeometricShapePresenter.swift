//
//  GeometricShapePresenter.swift
//  GemoetricShapes
//
//  Created by Gabriel Monteiro Camargo da Silva - GCM on 27/06/20.
//  Copyright © 2020 Gabriel Monteiro Camargo da Silva - GCM. All rights reserved.
//

import UIKit

class GeometricShapePresenter {
    var geometricShapesList: [UIView] = []
    var geometricShapesUndo: [UIView] = []
    var lastShapeMoved: UIView?
    
    var haveShapesInList: Bool {
        return geometricShapesList.count > 0
    }
    
    var haveShapeInUndoList: Bool {
        return geometricShapesUndo.count > 0
    }
    
    func addShapeInList(_ shape: UIView) {
        geometricShapesList.append(shape)
        geometricShapesUndo.removeAll()
    }
    
    func removeShapeFromList() -> UIView? {
        guard haveShapesInList else { return nil }
        let removedShape = geometricShapesList.removeLast()
        geometricShapesUndo.append(removedShape)
        return removedShape
    }
    
    func removeShapeFromUndoList() -> UIView? {
        guard haveShapeInUndoList else { return nil }
        let removedShape = geometricShapesUndo.removeLast()
        geometricShapesList.append(removedShape)
        return removedShape
    }
}
