//
//  Tree.swift
//  FractalTree
//
//  Created by Francesco  on 08/12/16.
//  Copyright © 2016 Francesco Saverio Zuppichini. All rights reserved.
//

import Foundation
import Cocoa
import SpriteKit


extension NSPoint{
    static func + (left: NSPoint, right: NSPoint) -> NSPoint {
        return NSPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func - (left: NSPoint, right: NSPoint) -> NSPoint {
        return NSPoint(x: left.x - right.x, y: left.y - right.y)
    }
}

class Tree{
    
    var branches: [Branch];
    var root: Branch?;
    var growFactor: CGFloat;
    var maxDepth: Int;
    var angle: CGFloat;
    var len: CGFloat;
    var start: NSPoint;
    
    init(start: NSPoint){
        self.branches = [];
        self.growFactor = 0.75;
        self.maxDepth = 9;
        self.angle = 45;
        self.len = 250;
        self.start = start;
        self.angle = 45.0;
        
    }
    
    func draw(_ path: NSBezierPath){
        // initialize root
        self.root = Branch(self.start,NSMakePoint(self.start.x,self.len),self);
        
        innerDraw(self.root!,self.maxDepth,path);
        
        
        print("created: ", self.branches.count , " branches");
    }
    
    
    func innerDraw(_ branch:Branch,_ deep:Int, _ path: NSBezierPath){
        
        branch.draw(path);

        self.branches.append(branch);
        
        if(deep <= 0){
            return;
        }
        
        
        let myTransformation = NSAffineTransform()
        
        // create a direction vector based on the prev branch
        var newEnd = branch.end - branch.start;
        
        myTransformation.scale(by: self.growFactor);
        // scale the vector
        newEnd = myTransformation.transform(newEnd);
        
        myTransformation.rotate(byDegrees: self.angle);
        // go on the left
        let leftEnd = myTransformation.transform(newEnd);
        
        myTransformation.rotate(byDegrees: -2 * self.angle);
        // go on the right
        let rightEnd =  myTransformation.transform(newEnd);
        // add back to the last end to get the new one
        newEnd = branch.end + newEnd;
        
        let leftBranch = Branch(branch.end, branch.end + leftEnd ,self);
        
        self.branches.append(branch);
        
        let rightBranch = Branch(branch.end,branch.end + rightEnd,self);
        
        let newDeep = deep - 1;
        
        //call recursion to create left and right branch
        innerDraw(leftBranch, newDeep,path);
        innerDraw(rightBranch, newDeep, path);
        
        
    }
    
}


