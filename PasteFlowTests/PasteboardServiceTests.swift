//
//  PasteboardServiceTests.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 06/12/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import XCTest
import VinceRP
@testable import PasteFlow

class PasteboardServiceTests: XCTestCase {

    let pasteboardService = PasteboardService()

    override func setUp() {
        super.setUp()
        pasteboardService.pasteboard.clearContents()
        pasteboardService.pasteboardItems <- [.Text("paste")]
    }

    func addItemToPasteboard() {
        pasteboardService.addItemToPasteboard(.Text("flow"))
        XCTAssertTrue(pasteboardService.pasteboardItems.value()[0] == .Text("flow"), "it should add new items")
    }

    func testpollPasteboardItems() {
        pasteboardService.pasteboard.writeObjects(["flow" as NSPasteboardWriting])
        pasteboardService.pollPasteboardItems()

        XCTAssertTrue(pasteboardService.pasteboardItems.value()[0] == .Text("flow"), "it should poll new items")
    }
}
