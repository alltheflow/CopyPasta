//
//  PasteViewController.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 29/10/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa
import VinceRP

class PasteViewController: NSViewController {
    var timer: NSTimer
    let pasteboardService = PasteboardService()
    
    required init?(coder aDecoder: NSCoder) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: pasteboardService, selector: "pollPasteboardItems", userInfo: nil, repeats: true)
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        pasteboardService.pasteboardItems.onChange { items in
            if let item = items.first as? String {
                print(item)
            }
        }
    }

}
