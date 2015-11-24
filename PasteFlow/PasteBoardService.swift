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
    let pasteboardItems = reactive([PasteboardItem]())
    let changeCount = reactive(0)

    // MARK: public methods

    @objc func pollPasteboardItems() {
        
        if (changeCount* == pasteboard.changeCount) {
            return
        }
        
        guard let items = pasteboard.readObjectsForClasses([NSString.self, NSImage.self, NSURL.self], options: nil)
            where items.count > 0 else {
            return
        }

        guard let item = pasteboardItem(items.first) else {
            return
        }

        pasteboardItems <- pasteboardItems*
            .filter { $0 != item }
            .arrayByPrepending(item)
        changeCount <- pasteboard.changeCount
    }

    func addItemToPasteboard(item: PasteboardItem) {
        pasteboard.clearContents()
        pasteboard.writeObjects([item.content as! NSPasteboardWriting])
        pollPasteboardItems()
    }

    // MARK: private methods

    private func pasteboardItem(item: AnyObject?) -> PasteboardItem? {
        let kind:PasteboardItem.Kind
        
        if item is NSString {
            kind = .Text
        } else if item is NSImage {
            kind = .Image
        } else {
            kind = .URL
        }
        
        return PasteboardItem(content: item!, kind: kind)
    }

}
