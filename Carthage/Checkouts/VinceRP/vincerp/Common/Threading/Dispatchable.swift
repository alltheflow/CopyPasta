//
// Created by Viktor Belenyesi on 27/09/15.
// Copyright (c) 2015 Viktor Belenyesi. All rights reserved.
//

// TODO: add tests
public protocol Dispatchable {
    typealias D
    
    func dispatchOnQueue(dispatchQueue: dispatch_queue_t?) -> D
    func dispatchOnMainQueue() -> D
    func dispatchOnCurrentQueue() -> D
    func dispatchOnBackgroundQueue() -> D
    
}

public extension Dispatchable {
    
    public func dispatchOnMainQueue() -> D {
        return self.dispatchOnQueue(dispatch_get_main_queue()!)
    }
    
    public func dispatchOnCurrentQueue() -> D {
        return self.dispatchOnQueue(nil)
    }
    
    public func dispatchOnBackgroundQueue() -> D {
        return self.dispatchOnQueue(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)!)
    }
    
}
