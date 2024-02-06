//
//  Hexagon.swift
//  Angstrom-POC
//
//  Created by Jamil Nawaz on 06/02/2024.
//

import Foundation
import SwiftUI

struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Points of the hexagon
        let point1 = CGPoint(x: width * 0.25, y: 0)
        let point2 = CGPoint(x: width * 0.75, y: 0)
        let point3 = CGPoint(x: width, y: height * 0.5)
        let point4 = CGPoint(x: width * 0.75, y: height)
        let point5 = CGPoint(x: width * 0.25, y: height)
        let point6 = CGPoint(x: 0, y: height * 0.5)
        
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.addLine(to: point4)
        path.addLine(to: point5)
        path.addLine(to: point6)
        path.closeSubpath()
        
        //        path.move(to: point3)
        //        path.addLine(to: point5)
        
        return path
    }
}
