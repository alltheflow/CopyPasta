//
//  PasteFlowTests.swift
//  PasteFlowTests
//
//  Created by Agnes Vasarhelyi on 29/10/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import XCTest
@testable import PasteFlow

class PasteFlowTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPasteboard() {
        let pasteboardService = PasteboardService()
        XCTAssertNotNil(pasteboardService, "cannot be nil")
    }
    
}
