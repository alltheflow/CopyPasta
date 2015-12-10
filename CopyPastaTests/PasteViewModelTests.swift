//
//  PasteViewModelTests.swift
//  CopyPasta
//
//  Created by Agnes Vasarhelyi on 06/12/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import XCTest
@testable import CopyPasta

class PasteViewModelTests: XCTestCase {

    let pasteViewModel = PasteViewModel()
    let pasteboard = NSPasteboard.generalPasteboard()
    
    override func setUp() {
        super.setUp()
        pasteboard.clearContents()
        pasteboard.writeObjects(["copy", "pasta"])
        pasteViewModel.pasteboardService.pollPasteboardItems()
    }
    
    func testSelectItemAtIndex() {
        pasteViewModel.selectItemAtIndex(1)

        XCTAssertTrue(pasteViewModel.items()[0] == .Text("pasta"), "it should readd existing items")
        XCTAssertTrue(pasteViewModel.items().count == 2, "it should not duplicate readded item")
    }

}
