//
// Created by Agnes Vasarhelyi on 17/11/15.
// Copyright (c) 2015 Viktor Belenyesi. All rights reserved.
//

import AppKit

public extension NSView {

    public var reactiveHidden: Hub<Bool> {
        get {
            return reactiveProperty(forProperty: "hidden", initValue: true)
        }

        set {
            newValue.onChange {
                self.hidden = self.mapReactiveHidden($0)
                self.reactiveHiddenDidChange()
            }.dispatchOnMainQueue()
        }
    }

    public func mapReactiveHidden(value: Bool) -> Bool {
        return value
    }

    public func reactiveHiddenDidChange() {}

}
