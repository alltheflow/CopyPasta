//
//  PasteboardPollingTests.swift
//  CopyPasta
//
//  Created by Agnes Vasarhelyi on 11/12/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import XCTest
@testable import CopyPasta

class PasteboardPollingTests: XCTestCase {

    func testpollPasteboardItems() {
        let pasteboardService = PasteboardService()
        pasteboardService.pasteboard.writeObjects(["pasta"])

        pasteboardService.pollPasteboardItems()

        XCTAssertTrue(pasteboardService.pasteboardItems.value()[0] == .Text("pasta"), "it should poll the new item")
    }

}
