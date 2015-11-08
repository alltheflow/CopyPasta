//
//  PasteboardViewController.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 29/10/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa
import VinceRP

class PasteboardLayout: NSCollectionViewFlowLayout {
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> NSCollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        attributes?.size = CGSizeMake((attributes?.size.width)!, CGFloat(indexPath.item) * CGFloat(20))
        return attributes
    }
    
    override func layoutAttributesForElementsInRect(rect: NSRect) -> [NSCollectionViewLayoutAttributes] {
        return super.layoutAttributesForElementsInRect(rect)
    }

}

class PasteboardViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {

    var timer: NSTimer
    let pasteboardService = PasteboardService()
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    required init?(coder aDecoder: NSCoder) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: pasteboardService, selector: "pollPasteboardItems", userInfo: nil, repeats: true)
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        let nib = NSNib(nibNamed: "TextItemCell", bundle: nil)
        collectionView.registerNib(nib, forItemWithIdentifier: "TextItemCell")
        pasteboardService.pasteboardItems.onChange { _ in self.collectionView.reloadData(); self.collectionView.layout() }
    }

    // MARK: NSCollectionViewDataSource

    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return pasteboardService.pasteboardItems*.count
    }

    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItemWithIdentifier("TextItemCell", forIndexPath: indexPath)
        let title = pasteboardService.pasteboardItems.value()[indexPath.item] as! String
        cell.textField!.stringValue = title
        return cell
    }

}
