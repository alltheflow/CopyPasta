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
    let textItemCellID = "TextItemCell"
    let imageItemCellID = "ImageItemCell"

    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var countLabel: NSTextField!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        // no KVO unfortunately
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: pasteboardService, selector: "pollPasteboardItems", userInfo: nil, repeats: true)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)!
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        let textItemNib = NSNib(nibNamed: textItemCellID, bundle: nil)
        let imageItemNib = NSNib(nibNamed: imageItemCellID, bundle: nil)

        collectionView.registerNib(textItemNib, forItemWithIdentifier: textItemCellID)
        collectionView.registerNib(imageItemNib, forItemWithIdentifier: imageItemCellID)

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
        let items = pasteboardService.pasteboardItems*

        if let item = items[indexPath.item] as? String {
            cell = collectionView.makeItemWithIdentifier(textItemCellID, forIndexPath: indexPath)
            cell.textField!.stringValue = item
        } else if let item = items[indexPath.item] as? NSImage {
            cell = collectionView.makeItemWithIdentifier(imageItemCellID, forIndexPath: indexPath)
            cell.imageView!.image = item
        }
        return cell
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> NSSize {
        let items = pasteboardService.pasteboardItems*
        if let item = items[indexPath.item] as? NSImage {
            return NSSize(width: collectionView.frame.size.width, height: item.size.height > 200 ? 200 : item.size.height)
        } else {
            return NSSize(width: collectionView.frame.size.width, height: 50)
        }
    }

    // MARK: NSCollectionViewDelegate
    
    func collectionView(collectionView: NSCollectionView, didSelectItemsAtIndexPaths indexPaths: Set<NSIndexPath>) {
        let items = pasteboardService.pasteboardItems*
        let index = indexPaths.first!.item
        let item = items[index]
        pasteboardService.addItemToPasteboard(item as! NSString)
    }
    
}
