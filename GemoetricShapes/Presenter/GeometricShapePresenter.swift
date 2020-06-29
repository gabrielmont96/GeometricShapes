//
//  GeometricShapePresenter.swift
//  GemoetricShapes
//
//  Created by Gabriel Monteiro Camargo da Silva - GCM on 27/06/20.
//  Copyright © 2020 Gabriel Monteiro Camargo da Silva - GCM. All rights reserved.
//

import Foundation

class GeometricShapePresenter {
    var geometricShapesList: [ShapeView] = []
    var geometricShapesUndo: [ShapeView] = []
    var lastShapeMoved: ShapeView?
    
    var haveShapesInList: Bool {
        return geometricShapesList.count > 0
    }
    
    var haveShapeInUndoList: Bool {
        return geometricShapesUndo.count > 0
    }
    
    func addShapeInList(_ shape: ShapeView) {
        geometricShapesList.append(shape)
        geometricShapesUndo.removeAll()
    }
    
    func removeShapeFromList() -> ShapeView? {
        guard haveShapesInList else { return nil }
        let removedShape = geometricShapesList.removeLast()
        geometricShapesUndo.append(removedShape)
        return removedShape
    }
    
    func removeShapeFromUndoList() -> ShapeView? {
        guard haveShapeInUndoList else { return nil }
        let removedShape = geometricShapesUndo.removeLast()
        geometricShapesList.append(removedShape)
        return removedShape
    }
}
