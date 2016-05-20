//
// UIControl+Tactile.swift
//
// Copyright (c) 2015-2016 Damien (http://delba.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

public extension Tactile where Self: UIControl {
    /**
        Attaches an event handler function for an event.
    
        - parameter event: A UIControlEvents event
        
        - parameter callback: The event handler function
        
        - returns: The control
    */
    func on(event: UIControlEvents, _ callback: Self -> Void) -> Self {
        let actor = Actor(control: self, event: event, callback: callback)
        
        addTarget(actor.proxy, action: .recognized, forControlEvents: event)
        
        return self
    }
    
    /**
        Attaches an event handler function for multiple events.
    
        - parameter events: An array of UIControlEvents
        
        - parameter callback: The event handler function
        
        - returns: The control
    */
    func on(events: [UIControlEvents], _ callback: Self -> Void) -> Self {
        for event in events {
            on(event, callback)
        }
        
        return self
    }
    
    /**
        Attaches event handler functions for different events.
        
        - parameter callbacks: A dictionary with a UIControlEvents event as the key and an event handler function as the value
        
        - returns: The control
    */
    func on(callbacks: [UIControlEvents: Self -> Void]) -> Self {
        for (event, callback) in callbacks {
            on(event, callback)
        }
        
        return self
    }
}

// MARK: Actor

private protocol Triggerable {
    func trigger(control: UIControl)
}

private struct Actor<T: UIControl>: Triggerable {
    let callback: T -> Void
    var proxy: Proxy!
    
    init(control: T, event: UIControlEvents, callback: T -> Void) {
        self.callback = callback
        self.proxy = Proxy(actor: self, control: control, event: event)
    }
    
    func trigger(control: UIControl) {
        if let control = control as? T {
            callback(control)
        }
    }
}

// MARK: Proxy

private var key = "io.delba.tactile.proxies"

private extension UIControl {
    var proxies: [UInt: Proxy] {
        get { return objc_getAssociatedObject(self, &key) as? [UInt: Proxy] ?? [:] }
        set { objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
}

private class Proxy: NSObject {
    var actor: Triggerable!
    
    init(actor: Triggerable, control: UIControl, event: UIControlEvents) {
        super.init()
        
        self.actor = actor
        control.proxies[event.rawValue] = self
    }
    
    @objc func recognized(control: UIControl) {
        actor.trigger(control)
    }
}

private extension Selector {
    static let recognized = #selector(Proxy.recognized(_:))
}
