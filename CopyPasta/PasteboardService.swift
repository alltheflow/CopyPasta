//
//  PasteboardService.swift
//  CopyPasta
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
        switch item {
            case .Text(let string):
                pasteboard.writeObjects([string as NSPasteboardWriting])
            case .Image(let image):
                pasteboard.writeObjects([image as NSPasteboardWriting])
            case .URL(let url):
                pasteboard.writeObjects([url as NSPasteboardWriting])
        }
        pollPasteboardItems()
    }

    func items() -> Hub<[PasteboardItem]> {
        return self.pasteboardItems
    }

    // MARK: private methods

    private func pasteboardItem(item: AnyObject?) -> PasteboardItem? {
        if let string = item as? String {
            return .Text(string)
        }
        
        if let image = item as? NSImage {
            return .Image(image)
        }
        
        if let url = item as? NSURL {
            return .URL(url)
        }
        
        fatalError("unsupported types")
    }

}
