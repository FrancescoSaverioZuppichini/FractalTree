//
//  Branch.swift
//  FractalTree
//
//  Created by Francesco  on 08/12/16.
//  Copyright © 2016 Francesco Saverio Zuppichini. All rights reserved.
//

import Foundation
import Cocoa

class Branch{
    var start: NSPoint;
    var end: NSPoint;
    var tree: Tree;
    var deep: Int;
    
    init(_ start: NSPoint,_ end: NSPoint,_ tree: Tree,_ deep : Int){
        self.start = start;
        self.end = end;
        self.tree = tree;
        self.deep = deep;
    }
    
    func draw(_ path: NSBezierPath){
        
        //        path.lineWidth = CGFloat(self.deep);
        path.move(to: self.start);
        path.line(to: self.end);
        
        path.stroke();
    }
    
}
