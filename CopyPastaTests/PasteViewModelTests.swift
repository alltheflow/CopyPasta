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

    func testSelectItemAtIndex() {
        let pasteViewModel = PasteViewModel()
        pasteViewModel.pasteboardService.addItemToPasteboard(.Text("copy"))
        pasteViewModel.pasteboardService.addItemToPasteboard(.Text("pasta"))

        pasteViewModel.selectItemAtIndex(0)

        XCTAssertTrue(pasteViewModel.items()[0] == .Text("pasta"), "it should readd existing items")
        XCTAssertTrue(pasteViewModel.items().count == 2, "it should not duplicate readded item")
    }

}
