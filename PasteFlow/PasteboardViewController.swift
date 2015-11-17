//
//  PasteboardViewController.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 29/10/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa
import VinceRP

class PasteboardViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {

    var timer: NSTimer
    let pasteboardService = PasteboardService()

    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var countLabel: NSTextField!

    required init?(coder aDecoder: NSCoder) {
        // no KVO unfortunately
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: pasteboardService, selector: "pollPasteboardItems", userInfo: nil, repeats: true)
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        let textItemNib = NSNib(nibNamed: "TextItemCell", bundle: nil)
        let imageItemNib = NSNib(nibNamed: "ImageItemCell", bundle: nil)

        collectionView.registerNib(textItemNib, forItemWithIdentifier: "TextItemCell")
        collectionView.registerNib(imageItemNib, forItemWithIdentifier: "ImageItemCell")

        pasteboardService.pasteboardItems.dispatchOnMainQueue().onChange { _ in self.collectionView.reloadData() }
        
        countLabel.reactiveText = self.pasteboardService.pasteboardItems.map { ("\($0.count) items") }
        countLabel.reactiveHidden = definedAs {
            self.pasteboardService.changeCount* == 0
        }
    }

    // MARK: NSCollectionViewDataSource

    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return pasteboardService.pasteboardItems*.count
    }

    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        var cell = NSCollectionViewItem()
        if let item = pasteboardService.pasteboardItems.value()[indexPath.item] as? String {
            cell = collectionView.makeItemWithIdentifier("TextItemCell", forIndexPath: indexPath)
            cell.textField!.stringValue = item
        } else if let item = pasteboardService.pasteboardItems.value()[indexPath.item] as? NSImage {
            cell = collectionView.makeItemWithIdentifier("ImageItemCell", forIndexPath: indexPath)
            cell.imageView!.image = item
        }
        return cell
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> NSSize {
        if let item = pasteboardService.pasteboardItems.value()[indexPath.item] as? NSImage {
            return NSSize(width: collectionView.frame.size.width, height: item.size.height > 200 ? 200 : item.size.height)
        } else {
            return NSSize(width: collectionView.frame.size.width, height: 50)
        }

    }

}
