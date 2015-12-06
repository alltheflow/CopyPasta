//
//  Created by Viktor Belenyesi on 11/24/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import AppKit

class PastePopoverBackgroundView: NSView {

    override var opaque: Bool {
        return true
    }

    override func drawRect(dirtyRect: NSRect) {
        NSColor.clearColor().set()
        NSRectFill(self.bounds)
    }
    
}