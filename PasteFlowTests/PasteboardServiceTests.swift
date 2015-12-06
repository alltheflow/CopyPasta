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
        pasteboardService.pasteboardItems <- [.Text("paste")]
    }

    override func tearDown() {
        super.tearDown()
    }

    func testpollPasteboardItems() {
        pasteboardService.addItemToPasteboard(.Text("flow"))
        pasteboardService.pollPasteboardItems()
        
        XCTAssertTrue(pasteboardService.pasteboardItems.value()[0] == .Text("flow"), "it should poll new items")
    }
}
