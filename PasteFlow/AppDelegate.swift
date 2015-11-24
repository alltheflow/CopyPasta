//
//  AppDelegate.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 29/10/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let popover = NSPopover()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "NSPathTemplate")
            button.action = Selector("togglePopover:")
        }
        
        popover.contentViewController = PasteboardViewController(nibName: "PasteboardViewController", bundle: nil)
    }

    func applicationWillTerminate(aNotification: NSNotification) { }

    // MARK: popover actions

    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            popover.performClose(sender)
        } else {
            if let button = statusItem.button {
                popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: .MinY)
            }
        }
    }
}

