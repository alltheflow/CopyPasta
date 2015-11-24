//
//  PasteboardItem.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 23/11/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa

func ==(lhs: PasteboardItem, rhs: PasteboardItem) -> Bool {
    if lhs.kind == rhs.kind {
        if lhs.kind == .Text {
            return lhs.content as! String == rhs.content as! String
        } else if lhs.kind == .Image {
            let lhsi = lhs.content as! NSImage
            let rhsi = rhs.content as! NSImage
            
            if let lhsiTiff = lhsi.TIFFRepresentation,
                let rhsiTiff = rhsi.TIFFRepresentation {
                    return lhsiTiff.isEqualToData(rhsiTiff);
            }
            return false
        } else {
            return lhs.content as! NSURL == rhs.content as! NSURL
        }
    }
    return false
}

func !=(lhs: PasteboardItem, rhs: PasteboardItem) -> Bool {
    return !(lhs == rhs)
}

struct PasteboardItem {
    enum Kind {
        case Text, URL, Image
    }
    
    let content: AnyObject
    let kind: Kind
}
