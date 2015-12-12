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
    
    func pasteboardItems() -> observable {
        return pasteboardService.pasteboardItems
    }

    func items() -> [PasteboardItem] {
        return pasteboardItems()*
    }

    func countHidden() -> Hub<Bool> {
        return pasteboardItems().map { $0.count == 0 }
    }

    func itemCountString() -> Hub<String> {
        return pasteboardItems()
            .dispatchOnMainQueue()
            .map { "\($0.count) items" }
    }

    func selectItemAtIndex(index: Int) {
        let item = self.items()[index]
        pasteboardService.addItemToPasteboard(item)
    }

    func itemAtIndex(index: Int) -> PasteboardItem {
        return self.items()[index]
    }

}
