//
// UIView+Tactile.swift
//
// Copyright (c) 2015-2019 Damien (http://delba.io)
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

import UIKit

public extension Tactile where Self: UIView {
    /**
        Attaches a gesture recognizer to the view for all its states.
    
        - parameter gesture: An object whose class descends from the UIGestureRecognizer class
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func on<T: UIGestureRecognizer>(_ gesture: T, _ callback: @escaping (T) -> Void) -> Self {
        let actor = Actor(gesture: gesture, callback: callback)

        addGestureRecognizer(actor, gesture)

        return self
    }

    /**
        Attaches a gesture recognizer to the view for a given state.
    
        - parameter gesture: An object whose class descends from the UIGestureRecognizer class
    
        - parameter state: The state the gesture recognizer should be in
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func on<T: UIGestureRecognizer>(_ gesture: T, _ state: UIGestureRecognizer.State, _ callback: @escaping (T) -> Void) -> Self {
        let actor = Actor(gesture: gesture, states: [state], callback: callback)

        addGestureRecognizer(actor, gesture)

        return self
    }

    /**
        Attaches a gesture recognizer to the view for multiple states.
    
        - parameter gesture: An object whose class descends from the UIGestureRecognizer class
    
        - parameter states: The states the gesture recognizer should be in
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func on<T: UIGestureRecognizer>(_ gesture: T, _ states: [UIGestureRecognizer.State], _ callback: @escaping (T) -> Void) -> Self {
        let actor = Actor(gesture: gesture, states: states, callback: callback)

        addGestureRecognizer(actor, gesture)

        return self
    }

    /**
        Attaches a gesture recognizer to the view and declares callbacks for its different states.
    
        - parameter gesture: An object whose class descends from the UIGestureRecognizer class
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    @discardableResult
    func on<T: UIGestureRecognizer>(_ gesture: T, _ callbacks: [UIGestureRecognizer.State: (T) -> Void]) -> Self {
        let actor = Actor(gesture: gesture, callbacks: callbacks)

        addGestureRecognizer(actor, gesture)

        return self
    }

    fileprivate func addGestureRecognizer<T: UIGestureRecognizer>(_ actor: Actor<T>, _ gesture: T) {
        guard let proxy = actor.proxy else { return }

        gesture.addTarget(proxy, action: .recognized)
        addGestureRecognizer(gesture)
    }
}

// MARK: Remove gesture recognizer

public extension Tactile where Self: UIView {
    /**
        Detaches a gesture recognizer from the receiving view.
    
        - parameter gesture: An object whose class descends from the UIGestureRecognizer class
    
        - returns: The view
    */
    @discardableResult
    func off(_ gesture: UIGestureRecognizer) -> Self {
        removeGestureRecognizer(gesture)

        return self
    }

    /**
        Detaches all the gestures recognizer of a given type from the receiving view.
    
        - parameter gestureType: A type of gesture recognizer
    
        - returns: The view
    */
    @discardableResult
    func off<T: UIGestureRecognizer>(_ gestureType: T.Type) -> Self {
        guard let gestures = gestureRecognizers else { return self }

        for gesture in gestures where gesture is T {
            removeGestureRecognizer(gesture)
        }

        return self
    }

    /**
        Detaches all the gestures recognizer from the receiving view.
    
        - returns: The view
    */
    @discardableResult
    func off() -> Self {
        guard let gestures = gestureRecognizers else { return self }

        for gesture in gestures {
            removeGestureRecognizer(gesture)
        }

        return self
    }
}

// MARK: Long press shorthand methods

public extension Tactile where Self: UIView {
    typealias LongPressCallback = (UILongPressGestureRecognizer) -> Void

    fileprivate var longPress: UILongPressGestureRecognizer {
        return UILongPressGestureRecognizer()
    }

    /**
        Attaches an instance of UILongPressGestureRecognizer to the view for all its states.
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func longPress(_ callback: @escaping LongPressCallback) -> Self {
        return on(longPress, callback)
    }

    /**
        Attaches an instance of UILongPressGestureRecognizer to the view for a given state.
    
        - parameter state: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func longPress(_ state: UIGestureRecognizer.State, _ callback: @escaping LongPressCallback) -> Self {
        return on(longPress, state, callback)
    }

    /**
        Attaches an instance of UILongPressGestureRecognizer to the view for a multiple states.
    
        - parameter states: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func longPress(_ states: [UIGestureRecognizer.State], _ callback: @escaping LongPressCallback) -> Self {
        return on(longPress, states, callback)
    }

    /**
        Attaches an instance of UILongPressGestureRecognizer to the view and declares callbacks for its different states.
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    @discardableResult
    func longPress(_ callbacks: [UIGestureRecognizer.State: LongPressCallback]) -> Self {
        return on(longPress, callbacks)
    }
}

// MARK: Pan shorthand methods

public extension Tactile where Self: UIView {
    typealias PanCallback = (UIPanGestureRecognizer) -> Void

    fileprivate var pan: UIPanGestureRecognizer {
        return UIPanGestureRecognizer()
    }

    /**
        Attaches an instance of UIPanGestureRecognizer to the view for all its states.
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func pan(_ callback: @escaping PanCallback) -> Self {
        return on(pan, callback)
    }

    /**
        Attaches an instance of UIPanGestureRecognizer to the view for a given state.
    
        - parameter state: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func pan(_ state: UIGestureRecognizer.State, _ callback: @escaping PanCallback) -> Self {
        return on(pan, state, callback)
    }

    /**
        Attaches an instance of UIPanGestureRecognizer to the view for a multiple states.
    
        - parameter states: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func pan(_ states: [UIGestureRecognizer.State], _ callback: @escaping PanCallback) -> Self {
        return on(pan, states, callback)
    }

    /**
        Attaches an instance UIPanGestureRecognizer to the view and declares callbacks for its different states.
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    @discardableResult
    func pan(_ callbacks: [UIGestureRecognizer.State: PanCallback]) -> Self {
        return on(pan, callbacks)
    }
}

// MARK: Pinch shorthand methods

public extension Tactile where Self: UIView {
    typealias PinchCallback = (UIPinchGestureRecognizer) -> Void

    fileprivate var pinch: UIPinchGestureRecognizer {
        return UIPinchGestureRecognizer()
    }

    /**
        Attaches an instance of UIPinchGestureRecognizer to the view for all its states.
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func pinch(_ callback: @escaping PinchCallback) -> Self {
        return on(pinch, callback)
    }

    /**
        Attaches an instance of UIPinchGestureRecognizer to the view for a given state.
    
        - parameter state: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func pinch(_ state: UIGestureRecognizer.State, _ callback: @escaping PinchCallback) -> Self {
        return on(pinch, state, callback)
    }

    /**
        Attaches an instance of UIPinchGestureRecognizer to the view for a multiple states.
    
        - parameter states: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func pinch(_ states: [UIGestureRecognizer.State], _ callback: @escaping PinchCallback) -> Self {
        return on(pinch, states, callback)
    }

    /**
        Attaches an instance UIPinchGestureRecognizer to the view and declares callbacks for its different states.
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    @discardableResult
    func pinch(_ callbacks: [UIGestureRecognizer.State: PinchCallback]) -> Self {
        return on(pinch, callbacks)
    }
}

// MARK: Rotation shorthand methods

public extension Tactile where Self: UIView {
    typealias RotationCallback = (UIRotationGestureRecognizer) -> Void

    fileprivate var rotation: UIRotationGestureRecognizer {
        return UIRotationGestureRecognizer()
    }

    /**
        Attaches an instance of UIRotationGestureRecognizer to the view.
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func rotation(_ callback: @escaping RotationCallback) -> Self {
        return on(rotation, callback)
    }

    /**
        Attaches an instance of UIRotationGestureRecognizer to the view for a given state.
    
        - parameter state: The states the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func rotation(_ state: UIGestureRecognizer.State, _ callback: @escaping RotationCallback) -> Self {
        return on(rotation, state, callback)
    }

    /**
        Attaches an instance of UIRotationGestureRecognizer to the view for a multiple states.
    
        - parameter states: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func rotation(_ states: [UIGestureRecognizer.State], _ callback: @escaping RotationCallback) -> Self {
        return on(rotation, states, callback)
    }

    /**
        Attaches an instance UIRotationGestureRecognizer to the view and declares callbacks for its different states.
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    @discardableResult
    func rotation(_ callbacks: [UIGestureRecognizer.State: RotationCallback]) -> Self {
        return on(rotation, callbacks)
    }
}

// MARK: Swipe shorthand methods

public extension Tactile where Self: UIView {
    typealias SwipeCallback = (UISwipeGestureRecognizer) -> Void

    fileprivate var swipe: UISwipeGestureRecognizer {
        return UISwipeGestureRecognizer()
    }

    /**
        Attaches an instance of UISwipeGestureRecognizer to the view for all its states.
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func swipe(_ callback: @escaping SwipeCallback) -> Self {
        return on(swipe, callback)
    }

    /**
        Attaches an instance of UISwipeGestureRecognizer to the view for a given state.
    
        - parameter state: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func swipe(_ state: UIGestureRecognizer.State, _ callback: @escaping SwipeCallback) -> Self {
        return on(swipe, state, callback)
    }

    /**
        Attaches an instance of UISwipeGestureRecognizer to the view for a multiple states.
    
        - parameter states: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func swipe(_ states: [UIGestureRecognizer.State], _ callback: @escaping SwipeCallback) -> Self {
        return on(swipe, states, callback)
    }

    /**
        Attaches an instance UISwipeGestureRecognizer to the view and declares callbacks for its different states.
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    @discardableResult
    func swipe(_ callbacks: [UIGestureRecognizer.State: SwipeCallback]) -> Self {
        return on(swipe, callbacks)
    }
}

// MARK: Tap shorthand methods

public extension Tactile where Self: UIView {
    typealias TapCallback = (UITapGestureRecognizer) -> Void

    fileprivate var tap: UITapGestureRecognizer {
        return UITapGestureRecognizer()
    }

    /**
        Attaches an instance of UITapGestureRecognizer to the view for all its states.
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func tap(_ callback: @escaping TapCallback) -> Self {
        return on(tap, callback)
    }

    /**
        Attaches an instance of UITapGestureRecognizer to the view for a given state.
    
        - parameter state: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func tap(_ state: UIGestureRecognizer.State, _ callback: @escaping TapCallback) -> Self {
        return on(tap, state, callback)
    }

    /**
        Attaches an instance of UITapGestureRecognizer to the view for a multiple states.
    
        - parameter states: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    @discardableResult
    func tap(_ states: [UIGestureRecognizer.State], _ callback: @escaping TapCallback) -> Self {
        return on(tap, states, callback)
    }

    /**
        Attaches an instance UITapGestureRecognizer to the view and declares callbacks for its different states.
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    @discardableResult
    func tap(_ callbacks: [UIGestureRecognizer.State: TapCallback]) -> Self {
        return on(tap, callbacks)
    }
}

// MARK: Actor

private protocol Triggerable {
    func trigger(_ gesture: UIGestureRecognizer)
}

private struct Actor<T: UIGestureRecognizer>: Triggerable {
    typealias State = UIGestureRecognizer.State
    typealias Callback = (T) -> Void

    var callbacks: [State: Callback] = [:]

    var proxy: Proxy?

    init(gesture: T, states: [State] = State.all, callback: @escaping Callback) {
        let gesture = gesture.proxy == nil ? gesture : gesture.clone()

        for state in states {
            self.callbacks[state] = callback
        }

        self.proxy = Proxy(actor: self, gesture: gesture)
    }

    init(gesture: T, callbacks: [State: Callback]) {
        let gesture = gesture.proxy == nil ? gesture : gesture.clone()

        self.callbacks = callbacks
        self.proxy = Proxy(actor: self, gesture: gesture)
    }

    func trigger(_ gesture: UIGestureRecognizer) {
        if let gesture = gesture as? T, let callback = callbacks[gesture.state] {
            callback(gesture)
        }
    }
}

// MARK: Proxy

private var key = "io.delba.tactile.proxy"

extension UIGestureRecognizer {
    fileprivate var proxy: Proxy? {
        get {
            var proxy: Proxy?

            synchronized {
                proxy = objc_getAssociatedObject(self, &key) as? Proxy
            }

            return proxy
        }

        set {
            synchronized {
                objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}

private class Proxy: NSObject {
    var actor: Triggerable?

    init(actor: Triggerable, gesture: UIGestureRecognizer) {
        super.init()
        self.actor = actor
        gesture.proxy = self
    }

    @objc func recognized(_ gesture: UIGestureRecognizer) {
        actor?.trigger(gesture)
    }
}

private extension Selector {
    static let recognized = #selector(Proxy.recognized(_:))
}
