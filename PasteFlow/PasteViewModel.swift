//
//  PasteViewModel.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 23/11/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Foundation
import VinceRP

class PasteViewModel {
    var timer: NSTimer
    let pasteboardService = PasteboardService()
    let pasteboardItems: Hub<[PasteboardItem]>

    init() {
        // no KVO unfortunately
        pasteboardItems = pasteboardService.pasteboardItems
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: pasteboardService, selector: "pollPasteboardItems", userInfo: nil, repeats: true)
    }

    func selectItemAtIndex(index: Int) {
        let items = pasteboardItems*
        let item = items[index]
        pasteboardService.addItemToPasteboard(item)
    }

    func itemAtIndex(index: Int) -> PasteboardItem {
        let items = pasteboardService.pasteboardItems*
        return items[index]
    }
}