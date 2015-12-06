//
//  PasteViewModelTests.swift
//  CopyPasta
//
//  Created by Agnes Vasarhelyi on 06/12/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import XCTest
@testable import CopyPasta

class MockedPasteViewModel: PasteViewModel {
    override func items() -> [PasteboardItem] {
        return [.Text("copy"), .Text("pasta")]
    }
}

class PasteViewModelTests: XCTestCase {

    let pasteViewModel = MockedPasteViewModel()
    
    func testSelectItemAtIndex() {
        pasteViewModel.selectItemAtIndex(0)
        XCTAssertTrue(pasteViewModel.items()[0] == .Text("copy"), "it should readd existing items")
    }

}
