//
//  PasteboardViewController.swift
//  CopyPasta
//
//  Created by Agnes Vasarhelyi on 29/10/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa
import VinceRP

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

    override func awakeFromNib() {
        let textItemNib = NSNib(nibNamed: textItemCellID, bundle: nil)
        let imageItemNib = NSNib(nibNamed: imageItemCellID, bundle: nil)

        collectionView.registerNib(textItemNib, forItemWithIdentifier: textItemCellID)
        collectionView.registerNib(imageItemNib, forItemWithIdentifier: imageItemCellID)

        pasteViewModel.pasteboardItems()
            .dispatchOnMainQueue().onChange { _ in self.collectionView.reloadData() }
        
        countLabel.reactiveHidden = pasteViewModel.countHidden()
        countLabel.reactiveText = pasteViewModel.itemCountString()
    }

    // MARK: NSCollectionViewDataSource

    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return pasteViewModel.items().count
    }

    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        var cell = PasteboardCollectionViewItem()
        let item = pasteViewModel.itemAtIndex(indexPath.item)
       
        switch (item) {
            case .Text(let string):
                cell = collectionView.makeItemWithIdentifier(textItemCellID, forIndexPath: indexPath) as! PasteboardCollectionViewItem
                cell.textField!.stringValue = string
                cell.textField?.toolTip = string
            case .Image(let image):
                cell = collectionView.makeItemWithIdentifier(imageItemCellID, forIndexPath: indexPath) as! PasteboardCollectionViewItem
                cell.imageView!.image = image
            default: break
        }

        cell.dateLabel.stringValue = self.timestamp()
        return cell
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> NSSize {
        let items = pasteViewModel.items()
        return sizeForItem(items[indexPath.item])
    }

    // MARK: NSCollectionViewDelegate
    
    func collectionView(collectionView: NSCollectionView, didSelectItemsAtIndexPaths indexPaths: Set<NSIndexPath>) {
        pasteViewModel.selectItemAtIndex(indexPaths.first!.item)
    }
    
    // MARK: Helper functions
    
    func timestamp() -> String {
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM. dd HH:mm"
        return dateFormatter.stringFromDate(date)
    }
    
    func heightForItem(item: PasteboardItem) -> CGFloat {
        let h = collectionView.frame.size.height
        switch (item) {
            case .Text(let text):
                let font = NSFont.systemFontOfSize(13)
                let textHeight = text.heightWithConstrainedWidth(348.0, font:font)
                return textHeight < 150 ? textHeight + 90 : 150
            case .Image(let image):
                return h > 159.0 ? 159.0 : image.size.height
            default: return h
        }
    }
    
    func sizeForItem(item: PasteboardItem) -> NSSize {
        let w = collectionView.frame.size.width
        return NSSize(width: w, height: heightForItem(item))
    }

}
