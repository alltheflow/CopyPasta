//
//  PFListViewController.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 29/10/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa

class PFListViewController: NSViewController {
    
    @IBOutlet weak var pasteLabel: NSTextField!
    @IBOutlet weak var pasteImageView: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let pasteboard = NSPasteboard.generalPasteboard()
        guard let items = pasteboard.readObjectsForClasses([NSString.self, NSImage.self], options: [String:AnyObject]()) else {
            return
        }
        
        if let text = items.first as? NSString {
            pasteLabel.stringValue = "\(text)"
        }
        
        if let image = items.first as? NSImage {
            pasteImageView.image = image
        }
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

