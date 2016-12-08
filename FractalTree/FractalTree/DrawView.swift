import Cocoa

class DrawView: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let tree = Tree(start: NSMakePoint(400, 0));
        // Drawing code here.
    
        let path = NSBezierPath();
       
        NSColor.black.set();
        
        tree.draw(path);
    }
 }
