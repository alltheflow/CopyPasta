//
//  PasteboardViewController.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 29/10/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa
import VinceRP

class PasteboardViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {

    var timer: NSTimer
    let pasteboardService = PasteboardService()
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    required init?(coder aDecoder: NSCoder) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: pasteboardService, selector: "pollPasteboardItems", userInfo: nil, repeats: true)
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        let nib = NSNib(nibNamed: "PasteboardItemCell", bundle: nil)
        collectionView.registerNib(nib, forItemWithIdentifier: "PasteboardItemCell")
        pasteboardService.pasteboardItems.onChange { _ in self.collectionView.reloadData() }
    }

    // MARK: NSCollectionViewDataSource

    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return pasteboardService.pasteboardItems*.count
    }

    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItemWithIdentifier("PasteboardItemCell", forIndexPath: indexPath)
        let title = pasteboardService.pasteboardItems.value()[indexPath.item] as! String
        cell.textField!.stringValue = title
        return cell
    }

}
