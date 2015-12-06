//
//  PasteboardItemTests.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 06/12/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import XCTest
@testable import PasteFlow

class PasteboardItemTests: XCTestCase {

    func testTextItem() {
        let textItem = PasteboardItem.Text("text")
        XCTAssert(textItem == .Text("text"), "should handle equal operator")
        XCTAssert(textItem != .Text("other text"), "should handle not equal operator")
    }

    func testImageItem() {
        let imageItem = PasteboardItem.Image(NSImage(named: "NSAdvanced")!)
        XCTAssert(imageItem == .Image(NSImage(named: "NSAdvanced")!), "should handle equal operator")
        XCTAssert(imageItem != .Image(NSImage(named: "NSApplicationIcon")!), "should handle not equal operator")
    }
    
    func testURLItem() {
        let urlItem = PasteboardItem.URL(NSURL(string: "http://url.com")!)
        XCTAssert(urlItem == .URL(NSURL(string: "http://url.com")!), "should handle equal operator")
        XCTAssert(urlItem != .URL(NSURL(string: "http://url.co.uk")!), "should handle not equal operator")
    }
}
