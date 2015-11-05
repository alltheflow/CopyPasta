//
//  PasteboardService.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 03/11/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa
import VinceRP

class PasteboardService {

    let pasteboard = NSPasteboard.generalPasteboard()
    var pasteboardItems = reactive([AnyObject]())

    var changeCount = reactive(0)
    
    @objc func pollPasteboardItems() {
        guard let items = self.pasteboard.readObjectsForClasses([NSString.self], options: nil) else {
            return
        }
        if self.changeCount* != self.pasteboard.changeCount {
            self.pasteboardItems <- items
            self.changeCount <- self.pasteboard.changeCount
        }
    }

}
