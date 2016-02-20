//
//  Tactile
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Damien D.
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

// MARK: Add gesture recognizer

public extension UIView {
    /**
        Attaches a gesture recognizer to the view for all its states.
    
        - parameter gesture: An object whose class descends from the UIGestureRecognizer class
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func on<T: UIGestureRecognizer>(gesture: T, _ callback: T -> Void) -> Self {
        let gesture = copyIfExists(gesture)
        
        let actor = Actor(gesture: gesture, callback: callback)
        
        gesture.addTarget(actor.proxy, action: "recognized:")
        
        self.addGestureRecognizer(gesture)
        
        return self
    }
    
    /**
        Attaches a gesture recognizer to the view for a given state.
    
        - parameter gesture: An object whose class descends from the UIGestureRecognizer class
    
        - parameter state: The state the gesture recognizer should be in
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func on<T: UIGestureRecognizer>(gesture: T, _ state: UIGestureRecognizerState, _ callback: T -> Void) -> Self {
        let gesture = copyIfExists(gesture)
        
        let actor = Actor(gesture: gesture, states: [state], callback: callback)
        
        gesture.addTarget(actor.proxy, action: "recognized:")
        
        self.addGestureRecognizer(gesture)
        
        return self
    }
    
    /**
        Attaches a gesture recognizer to the view for multiple states.
    
        - parameter gesture: An object whose class descends from the UIGestureRecognizer class
    
        - parameter states: The states the gesture recognizer should be in
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func on<T: UIGestureRecognizer>(gesture: T, _ states: [UIGestureRecognizerState], _ callback: T -> Void) -> Self {
        let gesture = copyIfExists(gesture)
        
        let actor = Actor(gesture: gesture, states: states, callback: callback)
        
        gesture.addTarget(actor.proxy, action: "recognized:")
        
        self.addGestureRecognizer(gesture)
        
        return self
    }
    
    /**
        Attaches a gesture recognizer to the view and declares callbacks for its different states.
    
        - parameter gesture: An object whose class descends from the UIGestureRecognizer class
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    func on<T: UIGestureRecognizer>(gesture: T, _ callbacks: [UIGestureRecognizerState: T -> Void]) -> Self {
        let gesture = copyIfExists(gesture)
        
        let actor = Actor(gesture: gesture, callbacks: callbacks)
        
        gesture.addTarget(actor.proxy, action: "recognized:")
        
        self.addGestureRecognizer(gesture)
        
        return self
    }
}

// MARK: Remove gesture recognizer

public extension UIView {
    /**
        Detaches a gesture recognizer from the receiving view.
    
        - parameter gesture: An object whose class descends from the UIGestureRecognizer class
    
        - returns: The view
    */
    func off(gesture: UIGestureRecognizer) -> Self {
        removeGestureRecognizer(gesture)
        
        return self
    }
    
    /**
        Detaches all the gestures recognizer of a given type from the receiving view.
    
        - parameter gestureType: A type of gesture recognizer
    
        - returns: The view
    */
    func off<T: UIGestureRecognizer>(gestureType: T.Type) -> Self {
        guard let gestures = gestureRecognizers else { return self }
        
        for gesture in gestures {
            removeGestureRecognizer(gesture)
        }
        
        return self
    }
    
    /**
        Detaches all the gestures recognizer from the receiving view.
    
        - returns: The view
    */
    func off() -> Self {
        guard let gestures = gestureRecognizers else { return self }
        
        for gesture in gestures {
            removeGestureRecognizer(gesture)
        }
        
        return self
    }
}

// MARK: Long press shorthand methods

public extension UIView {
    typealias LongPressCallback = UILongPressGestureRecognizer -> Void
    
    /**
        Attaches an instance of UILongPressGestureRecognizer to the view for all its states.
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func longPress(callback: LongPressCallback) -> Self {
        let longPress = UILongPressGestureRecognizer()
        return on(longPress, callback)
    }
    
    /**
        Attaches an instance of UILongPressGestureRecognizer to the view for a given state.
    
        - parameter state: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func longPress(state: UIGestureRecognizerState, _ callback: LongPressCallback) -> Self {
        let longPress = UILongPressGestureRecognizer()
        return on(longPress, state, callback)
    }
    
    func longPress(states: [UIGestureRecognizerState], _ callback: LongPressCallback) -> Self {
        let longPress = UILongPressGestureRecognizer()
        return on(longPress, states, callback)
    }
    
    func longPress(callbacks: [UIGestureRecognizerState: LongPressCallback]) -> Self {
        let longPress = UILongPressGestureRecognizer()
        return on(longPress, callbacks)
    }
}

// MARK: Pan shorthand methods

public extension UIView {
    typealias PanCallback = UIPanGestureRecognizer -> Void
    
    /**
        Attaches an instance of UIPanGestureRecognizer to the view for all its states.
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func pan(callback: PanCallback) -> Self {
        let pan = UIPanGestureRecognizer()
        return on(pan, callback)
    }
    
    /**
        Attaches an instance of UIPanGestureRecognizer to the view for a given state.
    
        - parameter state: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func pan(state: UIGestureRecognizerState, _ callback: PanCallback) -> Self {
        let pan = UIPanGestureRecognizer()
        return on(pan, state, callback)
    }
    
    /**
        Attaches an instance of UIPanGestureRecognizer to the view for a multiple states.
    
        - parameter states: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func pan(states: [UIGestureRecognizerState], _ callback: PanCallback) -> Self {
        let pan = UIPanGestureRecognizer()
        return on(pan, states, callback)
    }
    
    /**
        Attaches an instance UIPanGestureRecognizer to the view and declares callbacks for its different states.
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    func pan(callbacks: [UIGestureRecognizerState: PanCallback]) -> Self {
        let pan = UIPanGestureRecognizer()
        return on(pan, callbacks)
    }
}

// MARK: Pinch shorthand methods

public extension UIView {
    typealias PinchCallback = UIPinchGestureRecognizer -> Void
    
    /**
        Attaches an instance of UIPinchGestureRecognizer to the view for all its states.
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func pinch(callback: PinchCallback) -> Self {
        let pinch = UIPinchGestureRecognizer()
        return on(pinch, callback)
    }
    
    /**
        Attaches an instance of UIPinchGestureRecognizer to the view for a given state.
    
        - parameter state: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func pinch(state: UIGestureRecognizerState, _ callback: PinchCallback) -> Self {
        let pinch = UIPinchGestureRecognizer()
        return on(pinch, state, callback)
    }
    
    /**
        Attaches an instance of UIPinchGestureRecognizer to the view for a multiple states.
    
        - parameter states: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func pinch(states: [UIGestureRecognizerState], _ callback: PinchCallback) -> Self {
        let pinch = UIPinchGestureRecognizer()
        return on(pinch, states, callback)
    }
    
    /**
        Attaches an instance UIPinchGestureRecognizer to the view and declares callbacks for its different states.
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    func pinch(callbacks: [UIGestureRecognizerState: PinchCallback]) -> Self {
        let pinch = UIPinchGestureRecognizer()
        return on(pinch, callbacks)
    }
}

// MARK: Rotation shorthand methods

public extension UIView {
    typealias RotationCallback = UIRotationGestureRecognizer -> Void
    
    /**
        Attaches an instance of UIRotationGestureRecognizer to the view.
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func rotation(callback: RotationCallback) -> Self {
        let rotation = UIRotationGestureRecognizer()
        return on(rotation, callback)
    }
    
    /**
        Attaches an instance of UIRotationGestureRecognizer to the view for a given state.
    
        - parameter state: The states the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func rotation(state: UIGestureRecognizerState, _ callback: RotationCallback) -> Self {
        let rotation = UIRotationGestureRecognizer()
        return on(rotation, state, callback)
    }
    
    /**
        Attaches an instance of UIRotationGestureRecognizer to the view for a multiple states.
    
        - parameter states: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func rotation(states: [UIGestureRecognizerState], _ callback: RotationCallback) -> Self {
        let rotation = UIRotationGestureRecognizer()
        return on(rotation, states, callback)
    }
    
    /**
        Attaches an instance UIRotationGestureRecognizer to the view and declares callbacks for its different states.
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    func rotation(callbacks: [UIGestureRecognizerState: RotationCallback]) -> Self {
        let rotation = UIRotationGestureRecognizer()
        return on(rotation, callbacks)
    }
}

// MARK: Swipe shorthand methods

public extension UIView {
    typealias SwipeCallback = UISwipeGestureRecognizer -> Void
    
    /**
        Attaches an instance of UISwipeGestureRecognizer to the view for all its states.
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func swipe(callback: SwipeCallback) -> Self {
        let swipe = UISwipeGestureRecognizer()
        return on(swipe, callback)
    }
    
    /**
        Attaches an instance of UISwipeGestureRecognizer to the view for a given state.
    
        - parameter state: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func swipe(state: UIGestureRecognizerState, _ callback: SwipeCallback) -> Self {
        let swipe = UISwipeGestureRecognizer()
        return on(swipe, state, callback)
    }
    
    /**
        Attaches an instance of UISwipeGestureRecognizer to the view for a multiple states.
    
        - parameter states: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func swipe(states: [UIGestureRecognizerState], _ callback: SwipeCallback) -> Self {
        let swipe = UISwipeGestureRecognizer()
        return on(swipe, states, callback)
    }
    
    /**
        Attaches an instance UISwipeGestureRecognizer to the view and declares callbacks for its different states.
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    func swipe(callbacks: [UIGestureRecognizerState: SwipeCallback]) -> Self {
        let swipe = UISwipeGestureRecognizer()
        return on(swipe, callbacks)
    }
}

// MARK: Tap shorthand methods

public extension UIView {
    typealias TapCallback = UITapGestureRecognizer -> Void
    
    /**
        Attaches an instance of UITapGestureRecognizer to the view for all its states.
    
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func tap(callback: TapCallback) -> Self {
        let tap = UITapGestureRecognizer()
        return on(tap, callback)
    }
    
    /**
        Attaches an instance of UITapGestureRecognizer to the view for a given state.
    
        - parameter state: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func tap(state: UIGestureRecognizerState, _ callback: TapCallback) -> Self {
        let tap = UITapGestureRecognizer()
        return on(tap, state, callback)
    }
    
    /**
        Attaches an instance of UITapGestureRecognizer to the view for a multiple states.
    
        - parameter states: The state the gesture recognizer should be in
        - parameter callback: A function to be invoked when the gesture occurs
    
        - returns: The view
    */
    func tap(states: [UIGestureRecognizerState], _ callback: TapCallback) -> Self {
        let tap = UITapGestureRecognizer()
        return on(tap, states, callback)
    }
    
    /**
        Attaches an instance UITapGestureRecognizer to the view and declares callbacks for its different states.
    
        - parameter callbacks: A dictionary with a state as the key and a callback as the value
    
        - returns: The view
    */
    func tap(callbacks: [UIGestureRecognizerState: TapCallback]) -> Self {
        let tap = UITapGestureRecognizer()
        return on(tap, callbacks)
    }
}

private var key = "tactile_view_proxy"

extension UIGestureRecognizer {
    private var proxy: Proxy! {
        get { return objc_getAssociatedObject(self, &key) as? Proxy }
        set { objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
}

// MARK: Actor

private protocol Triggerable {
    func trigger(gesture gesture: UIGestureRecognizer)
}

private extension UIGestureRecognizerState {
    static let all = [
        Possible, Began, Changed, Ended, Cancelled, Failed
    ]
}

private struct Actor<T: UIGestureRecognizer>: Triggerable {
    typealias State = UIGestureRecognizerState
    typealias Callback = T -> Void
    
    var callbacks = [State: Callback]()
    
    var proxy: Proxy!

    init(gesture: T, states: [State] = State.all, callback: Callback) {
        for state in states {
            self.callbacks[state] = callback
        }
        
        self.proxy = Proxy(actor: self, gesture: gesture)
    }
    
    init(gesture: T, callbacks: [State: Callback]) {
        self.callbacks = callbacks
        self.proxy = Proxy(actor: self, gesture: gesture)
    }
    
    func trigger(gesture gesture: UIGestureRecognizer) {
        if let gesture = gesture as? T, callback = callbacks[gesture.state] {
            callback(gesture)
        }
    }
}

// MARK: Proxy

private class Proxy: NSObject {
    var actor: Triggerable!
    
    init(actor: Triggerable, gesture: UIGestureRecognizer) {
        super.init()
        self.actor = actor
        gesture.proxy = self
    }
    
    @objc func recognized(gesture: UIGestureRecognizer) {
        actor.trigger(gesture: gesture)
    }
}

// MARK: Internal functions

func copyIfExists<T: UIGestureRecognizer>(a: T) -> T {
    if a.proxy == nil { return a }
    
    let b = T()
    
    downcast(a, b: b, to: UILongPressGestureRecognizer.self) { a, b in
        b.numberOfTapsRequired = a.numberOfTapsRequired
        b.numberOfTouchesRequired = a.numberOfTouchesRequired
        b.minimumPressDuration = a.minimumPressDuration
        b.allowableMovement = a.allowableMovement
    }
    
    downcast(a, b: b, to: UIPanGestureRecognizer.self) { a, b in
        b.maximumNumberOfTouches = a.maximumNumberOfTouches
        b.minimumNumberOfTouches = a.minimumNumberOfTouches
    }
    
    downcast(a, b: b, to: UIScreenEdgePanGestureRecognizer.self) { a, b in
        b.edges = a.edges
    }
    
    downcast(a, b: b, to: UISwipeGestureRecognizer.self) { a, b in
        b.direction = a.direction
        b.numberOfTouchesRequired = a.numberOfTouchesRequired
    }
    
    downcast(a, b: b, to: UITapGestureRecognizer.self) { a, b in
        b.numberOfTapsRequired = a.numberOfTapsRequired
        b.numberOfTouchesRequired = a.numberOfTouchesRequired
    }
    
    return b
}

func downcast<T, U>(a: T, b: T, to: U.Type, block: (U, U) -> Void) {
    if let a = a as? U, b = b as? U {
        block(a, b)
    }
}