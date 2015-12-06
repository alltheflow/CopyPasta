//
//  PasteViewModelTests.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 06/12/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import XCTest
import VinceRP
@testable import PasteFlow

class MockedPasteViewModel: PasteViewModel {
    override func items() -> [PasteboardItem] {
        return [.Text("paste"), .Text("flow")]
    }
}

class PasteViewModelTests: XCTestCase {

    let pasteViewModel = MockedPasteViewModel()
    
    func testSelectItemAtIndex() {
        pasteViewModel.selectItemAtIndex(0)
        XCTAssertTrue(pasteViewModel.items()[0] == .Text("paste"), "it should poll new items")
    }

}
