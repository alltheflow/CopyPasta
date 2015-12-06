//
//  AppDelegate.swift
//  CopyPasta
//
//  Created by Agnes Vasarhelyi on 29/10/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import AppKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let popover = NSPopover()
    var popoverTransiencyMonitor: AnyObject?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusItem.button!.image = NSImage(named: "pasta_icon")
        statusItem.button!.action = Selector("togglePopover:")

        popover.behavior = .Semitransient
        popover.contentViewController = PasteboardViewController(nibName: "PasteboardViewController", bundle: nil)
    }

    func applicationWillTerminate(aNotification: NSNotification) { }

    // MARK: popover actions

    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            openPopover(sender)
        }
    }
    
    func openPopover(sender: AnyObject?) {
        popover.showRelativeToRect(statusItem.button!.bounds, ofView: statusItem.button!, preferredEdge: .MinY)
        
        guard popoverTransiencyMonitor == nil else {
            return
        }
        
        popoverTransiencyMonitor = NSEvent.addGlobalMonitorForEventsMatchingMask([.RightMouseDownMask, .LeftMouseDownMask]) {_ in
            self.closePopover(sender)
        }
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        
        guard let monitor = popoverTransiencyMonitor else {
            return
        }
        
        NSEvent.removeMonitor(monitor)
        popoverTransiencyMonitor = nil
    }
    
}

