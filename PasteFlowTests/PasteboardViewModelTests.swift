//
//  PasteboardViewModelTests.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 29/11/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import XCTest
import VinceRP
@testable import PasteFlow

class MockedPasteboardService: PasteboardService {
    let pasteboardItems = reactive([PasteboardItem.Text("testitem"), PasteboardItem.URL(NSURL(string: "http://url.com")!)])
}

class PasteboardViewModelTests: XCTestCase {

    let pasteboardService = PasteboardService()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testItemAtIndex() {
        
    }

}
