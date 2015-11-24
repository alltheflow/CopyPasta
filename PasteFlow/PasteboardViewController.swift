//
//  PasteboardViewController.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 29/10/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa

class PasteboardViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {

    let textItemCellID = "TextItemCell"
    let imageItemCellID = "ImageItemCell"
    let pasteViewModel = PasteViewModel()
    
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var countLabel: NSTextField!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)!
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func loadView() {
//        self.view = PastePopoverRootView()
//    }

    override func awakeFromNib() {
        let textItemNib = NSNib(nibNamed: textItemCellID, bundle: nil)
        let imageItemNib = NSNib(nibNamed: imageItemCellID, bundle: nil)

        collectionView.registerNib(textItemNib, forItemWithIdentifier: textItemCellID)
        collectionView.registerNib(imageItemNib, forItemWithIdentifier: imageItemCellID)

        countLabel.reactiveText = pasteViewModel.pasteboardItems.dispatchOnMainQueue().map {
            "\($0.count) items"
        }
        pasteViewModel.pasteboardItems.dispatchOnMainQueue().onChange { _ in self.collectionView.reloadData() }
    }

    // MARK: NSCollectionViewDataSource

    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return pasteViewModel.items.count
    }

    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        var cell = NSCollectionViewItem()
        let item = pasteViewModel.itemAtIndex(indexPath.item)
        
        switch (item) {
        case .Text(let string):
            cell = collectionView.makeItemWithIdentifier(textItemCellID, forIndexPath: indexPath)
            cell.textField!.stringValue = string
        case .Image(let image):
            cell = collectionView.makeItemWithIdentifier(imageItemCellID, forIndexPath: indexPath)
            cell.imageView!.image = image
        default: break
        }
        
        return cell
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> NSSize {
        let items = pasteViewModel.items
        return sizeForItem(items[indexPath.item])
    }

    // MARK: NSCollectionViewDelegate
    
    func collectionView(collectionView: NSCollectionView, didSelectItemsAtIndexPaths indexPaths: Set<NSIndexPath>) {
        pasteViewModel.selectItemAtIndex(indexPaths.first!.item)
    }
    
    // MARK: Helper functions
    
    func sizeForItem(item: PasteboardItem) -> NSSize {
        let w = collectionView.frame.size.width
        switch (item) {
        case .Text(_):
            return NSSize(width: w, height: 110.0)
        case .Image(_):
            return NSSize(width: w, height: 229.0)
        default: break
        }
        return NSSize(width: w, height: 50.0)
    }

}
