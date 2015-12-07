//
//  MainViewController.swift
//  CopyPasta
//
//  Created by Agnes Vasarhelyi on 07/12/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var contentView: NSView!
    
    override func awakeFromNib() {
        let pasteboardViewController = PasteboardViewController(nibName: "PasteboardViewController", bundle: nil)
        contentView.addSubview(pasteboardViewController.view)
    }

}
