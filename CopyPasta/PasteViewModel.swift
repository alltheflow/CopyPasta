//
//  PasteViewModel.swift
//  CopyPasta
//
//  Created by Agnes Vasarhelyi on 23/11/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Foundation
import VinceRP

class PasteViewModel {
    let pasteboardService = PasteboardService()

    init() {
        timer(1.0) {
            self.pasteboardService.pollPasteboardItems()
        }        
    }
    
    var pasteboardItems: Hub<[PasteboardItem]> {
        return pasteboardService.pasteboardItems
    }

    var items: [PasteboardItem] {
        return pasteboardItems*
    }

    func selectItemAtIndex(index: Int) {
        let item = self.items[index]
        pasteboardService.addItemToPasteboard(item)
    }

    func itemAtIndex(index: Int) -> PasteboardItem {
        return self.items[index]
    }

}
