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
    var lineWidthBase: CGFloat;
    var noise: CGFloat;
    
    init(start: NSPoint){
        self.branches = [];
        self.growFactor = 0.8;
        self.maxDepth = 2;
        self.angle = 45;
        self.len = 200;
        self.start = start;
        self.lineWidthBase = 1.0;
        self.noise = 0;
        
    }
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func draw(_ path: NSBezierPath){
        
        // initialize root
        self.root = Branch(self.start,NSMakePoint(self.start.x,self.len),self,0);
        // set the default line width
        path.lineWidth = self.lineWidthBase;
        // call the inner function that will draw, create and store all the branches
        innerDraw(self.root!,self.maxDepth,path);

        print("created: ", self.branches.count , " branches");
    }
    
    
    func innerDraw(_ branch:Branch,_ deep:Int, _ path: NSBezierPath){
        
        
        let randomAngle = self.randomBetweenNumbers(firstNum: self.angle - self.noise, secondNum: self.angle + self.noise);

        // draw current branch
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
        
        myTransformation.rotate(byDegrees: randomAngle);
        // go on the left
        let leftEnd = myTransformation.transform(newEnd);
        
        myTransformation.rotate(byDegrees: -2 * randomAngle);
        // go on the right
        let rightEnd =  myTransformation.transform(newEnd);
        // add back to the last end to get the new one
        newEnd = branch.end + newEnd;
        
        let leftBranch = Branch(branch.end, branch.end + leftEnd, self, deep);
        
        self.branches.append(branch);
        
        let rightBranch = Branch(branch.end,branch.end + rightEnd,self, deep);
        
        let newDeep = deep - 1;
        
        //call recursion to create left and right branch
        
        innerDraw(leftBranch, newDeep, path);
        innerDraw(rightBranch, newDeep, path);
        
        
    }
    
}


