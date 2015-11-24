//
//  Created by Viktor Belenyesi on 11/24/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import AppKit

class PastePopoverRootView: NSView {
    
    override func viewDidMoveToWindow() {
        let frameView = self.window?.contentView?.superview
        let backgroundView = PastePopoverBackgroundView(frame: frameView!.bounds)
        backgroundView.alphaValue = 0.9
        backgroundView.autoresizingMask = [.ViewWidthSizable, .ViewHeightSizable]
        frameView?.addSubview(backgroundView, positioned: .Below, relativeTo: frameView)
        super.viewDidMoveToWindow()
    }
    
}