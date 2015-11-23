//
//  PasteboardService.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 03/11/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa
import VinceRP

func ==(lhs: PasteboardItem, rhs: PasteboardItem) -> Bool {
    if lhs.kind == rhs.kind {
        if lhs.kind == .Text {
            return lhs.content as! String == rhs.content as! String
        } else if lhs.kind == .Image {
            return lhs.content as! NSImage == lhs.content as! NSImage
        } else {
            return lhs.content as! NSURL == rhs.content as! NSURL
        }
    }
    return false
}

func !=(lhs: PasteboardItem, rhs: PasteboardItem) -> Bool {
    return !(lhs == rhs)
}

struct PasteboardItem {
    enum Kind {
        case Text, URL, Image
    }
    
    let content: AnyObject
    let kind: Kind
}

class PasteboardService {

    let pasteboard = NSPasteboard.generalPasteboard()
    let pasteboardItems = reactive([PasteboardItem]())
    let changeCount = reactive(0)

    @objc func pollPasteboardItems() {

        if (changeCount* != pasteboard.changeCount) {
            guard let items = pasteboard.readObjectsForClasses([NSString.self, NSImage.self, NSURL.self], options: nil)
                where items.count > 0 else {
                return
            }

            guard let item = pasteboardItem(items.first) else {
                return
            }

            pasteboardItems <- pasteboardItems*
                .filter { pbItem in
                    return pbItem != item
                }
                .arrayByPrepending(item)
            changeCount <- pasteboard.changeCount
        }
    }

    func addItemToPasteboard(item: PasteboardItem) {
        pasteboard.clearContents()
        pasteboard.writeObjects([item.content as! NSPasteboardWriting])
        pollPasteboardItems()
    }
    
    func pasteboardItem(item: AnyObject?) -> PasteboardItem? {
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
