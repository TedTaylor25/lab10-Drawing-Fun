//
//  StretchView.swift
//  DrawingFun
//
//  Created by David Eyers on 20/09/16.
//  Updated for Xcode 8.3 and Swift 3.x in September 2017
//

import Cocoa

class StretchView: NSView {
    
    var path = NSBezierPath()
    
    dynamic var opacity:Float = 1.0
    dynamic var image:NSImage = NSImage()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        srandom(2)
        path.lineWidth = 3.0
        var p:NSPoint = self.randomPoint()
        path.move(to: p)
        
        for _ in 0...14 {
            p = self.randomPoint()
            path.line(to: p)
        }
        path.close()
    }
    
    func randomPoint()->NSPoint {
        let r:NSRect = self.bounds
        let nx = r.origin.x + CGFloat(Int(arc4random()) % Int(r.size.width))
        let ny = r.origin.y + CGFloat(Int(arc4random()) % Int(r.size.height))
        return NSPoint(x: nx, y: ny)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let bounds = self.bounds
        NSColor.green.set()
        NSBezierPath.fill(bounds)
        
        NSColor.white.set()
        path.stroke()
        
        // draw image
        var imageRect = NSRect()
        imageRect.origin = NSZeroPoint
        imageRect.size = image.size
        let drawingRect = imageRect
        image.draw(in: drawingRect, from: imageRect,
                         operation: NSCompositingOperation.sourceOver,
                         fraction: CGFloat(opacity))
    }
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 400, height: 400)
    }
    
    override func mouseDown(with theEvent: NSEvent) {
        NSLog("mouseDown: \(theEvent.clickCount)")
    }
    override func mouseDragged(with theEvent: NSEvent) {
        NSLog("mouseDragged: \(theEvent.locationInWindow)")
    }
    override func mouseUp(with theEvent: NSEvent) {
        NSLog("mouseUp:")
    }
    
}
