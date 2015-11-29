//
//  PasteboardItem.swift
//  PasteFlow
//
//  Created by Agnes Vasarhelyi on 23/11/15.
//  Copyright © 2015 Agnes Vasarhelyi. All rights reserved.
//

import Cocoa

extension NSImage {
    
    public override func isEqualTo(object: AnyObject?) -> Bool {
        guard let otherImage = object as? NSImage else {
            return false
        }
        
        guard let lhsiTiff = self.TIFFRepresentation,
            let rhsiTiff = otherImage.TIFFRepresentation  else {
                return false
            }
        
        return lhsiTiff.isEqualToData(rhsiTiff)
    }
    
}

func ==(lhs: PasteboardItem, rhs: PasteboardItem) -> Bool {
    switch (lhs, rhs) {
    case (.Text(let str1), .Text(let str2)): return str1 == str2
    case (.Image(let img1), .Image(let img2)): return img1.isEqualTo(img2)
    case (.URL(let str1), .URL(let str2)): return str1 == str2
    default: return false
    }
}

func !=(lhs: PasteboardItem, rhs: PasteboardItem) -> Bool {
    return !(lhs == rhs)
}

enum PasteboardItem {
    case Text(String)
    case URL(NSURL)
    case Image(NSImage)
}
