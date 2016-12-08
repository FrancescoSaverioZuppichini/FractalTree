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
    
    init(_ start: NSPoint,_ end: NSPoint,_ tree: Tree){
        self.start = start;
        self.end = end;
        self.tree = tree;
    }
     
    func draw(_ path: NSBezierPath){
        
        path.move(to: self.start);
        path.line(to: self.end);
        
        path.stroke();
    }
    
}
