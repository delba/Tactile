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

// MARK: Hashable

extension UIControlEvents: Hashable {
    public var hashValue: Int { return Int(rawValue) }
}

// MARK: UIControl

private extension UIControl {
    /**
        Attaches an event handler function for an event.
    
        :param: control An object whose class descends from the UIControl class
    
        :param: event A UIControlEvents event
    
        :param: callback The event handler function
        
        :returns: The control
    */
    func on<T: UIControl>(control: T, event: UIControlEvents, callback: T -> Void) -> T {
        let actor = Actor(control: control, event: event, callback: callback)
        
        addTarget(actor.proxy, action: "recognized:", forControlEvents: event)
        
        return control
    }
    
    /**
        Attaches an event handler function for multiple events.
    
        :param: control An object whose class descends from the UIControl class
    
        :param: events An array of UIControlEvents
    
        :param: callback The event handler function
        
        :returns: The control
    */
    func on<T: UIControl>(control: T, events: [UIControlEvents], callback: T -> Void) -> T {
        for event in events {
            on(control, event: event, callback: callback)
        }
        
        return control
    }
    
    /**
        Attaches event handler functions for different events.
    
        :param: control An object whose class descends from the UIControl class
    
        :param: callbacks A dictionary with a UIControlEvents event as the key and an event handler function as the value
        
        :returns: The control
    */
    func on<T: UIControl>(control: T, callbacks: [UIControlEvents: T -> Void]) -> T {
        for (event, callback) in callbacks {
            on(control, event: event, callback: callback)
        }
        
        return control
    }
}

// MARK: UIButton

public extension UIButton {
    /**
        Attaches an event handler function for an event.
    
        :param: event A UIControlEvents event
    
        :param: callback The event handler function
        
        :returns: The button
    */
    func on(event: UIControlEvents, _ callback: UIButton -> Void) -> UIButton {
        return super.on(self, event: event, callback: callback)
    }
    
    /**
        Attaches an event handler function for multiple events.
    
        :param: events An array of UIControlEvents
    
        :param: callback The event handler function
        
        :returns: The button
    */
    func on(events: [UIControlEvents], _ callback: UIButton -> Void) -> UIButton {
        return super.on(self, events: events, callback: callback)
    }
    
    /**
        Attaches event handler functions for different events.
    
        :param: callbacks A dictionary with a UIControlEvents event as the key and an event handler function as the value
        
        :returns: The button
    */
    func on(callbacks: [UIControlEvents: UIButton -> Void]) -> UIButton {
        return super.on(self, callbacks: callbacks)
    }
}

// MARK: UIDatePicker

public extension UIDatePicker {
    /**
        Attaches an event handler function for an event.
    
        :param: event A UIControlEvents event
    
        :param: callback The event handler function
        
        :returns: The datepicker
    */
    func on(event: UIControlEvents, _ callback: UIDatePicker -> Void) -> UIDatePicker {
        return super.on(self, event: event, callback: callback)
    }
    
    /**
        Attaches an event handler function for multiple events.
    
        :param: events An array of UIControlEvents
    
        :param: callback The event handler function
        
        :returns: The datepicker
    */
    func on(events: [UIControlEvents], _ callback: UIDatePicker -> Void) -> UIDatePicker {
        return super.on(self, events: events, callback: callback)
    }
    
    /**
        Attaches event handler functions for different events.
    
        :param: callbacks A dictionary with a UIControlEvents event as the key and an event handler function as the value
        
        :returns: The button
    */
    func on(callbacks: [UIControlEvents: UIDatePicker -> Void]) -> UIDatePicker {
        return super.on(self, callbacks: callbacks)
    }
}

// MARK: UIPageControl

public extension UIPageControl {
    /**
        Attaches an event handler function for an event.
    
        :param: event A UIControlEvents event
    
        :param: callback The event handler function
        
        :returns: The page control
    */
    func on(event: UIControlEvents, _ callback: UIPageControl -> Void) -> UIPageControl {
        return super.on(self, event: event, callback: callback)
    }
    
    /**
        Attaches an event handler function for multiple events.
    
        :param: events An array of UIControlEvents
    
        :param: callback The event handler function
        
        :returns: The page control
    */
    func on(events: [UIControlEvents], _ callback: UIPageControl -> Void) -> UIPageControl {
        return super.on(self, events: events, callback: callback)
    }
    
    /**
        Attaches event handler functions for different events.
    
        :param: callbacks A dictionary with a UIControlEvents event as the key and an event handler function as the value
        
        :returns: The button
    */
    func on(callbacks: [UIControlEvents: UIPageControl -> Void]) -> UIPageControl {
        return super.on(self, callbacks: callbacks)
    }
}

// MARK: UIRefreshControl

public extension UIRefreshControl {
    /**
        Attaches an event handler function for an event.
    
        :param: event A UIControlEvents event
    
        :param: callback The event handler function
        
        :returns: The refresh control
    */
    func on(event: UIControlEvents, _ callback: UIRefreshControl -> Void) -> UIRefreshControl {
        return super.on(self, event: event, callback: callback)
    }
    
    /**
        Attaches an event handler function for multiple events.
    
        :param: events An array of UIControlEvents
    
        :param: callback The event handler function
        
        :returns: The refresh control
    */
    func on(events: [UIControlEvents], _ callback: UIRefreshControl -> Void) -> UIRefreshControl {
        return super.on(self, events: events, callback: callback)
    }
    
    /**
        Attaches event handler functions for different events.
    
        :param: callbacks A dictionary with a UIControlEvents event as the key and an event handler function as the value
        
        :returns: The button
    */
    func on(callbacks: [UIControlEvents: UIRefreshControl -> Void]) -> UIRefreshControl {
        return super.on(self, callbacks: callbacks)
    }
}

// MARK: UISegmentedControl

public extension UISegmentedControl {
    /**
        Attaches an event handler function for an event.
    
        :param: event A UIControlEvents event
    
        :param: callback The event handler function
        
        :returns: The segmented control
    */
    func on(event: UIControlEvents, _ callback: UISegmentedControl -> Void) -> UISegmentedControl {
        return super.on(self, event: event, callback: callback)
    }
    
    /**
        Attaches an event handler function for multiple events.
    
        :param: events An array of UIControlEvents
    
        :param: callback The event handler function
        
        :returns: The segmented control
    */
    func on(events: [UIControlEvents], _ callback: UISegmentedControl -> Void) -> UISegmentedControl {
        return super.on(self, events: events, callback: callback)
    }
    
    /**
        Attaches event handler functions for different events.
    
        :param: callbacks A dictionary with a UIControlEvents event as the key and an event handler function as the value
        
        :returns: The button
    */
    func on(callbacks: [UIControlEvents: UISegmentedControl -> Void]) -> UISegmentedControl {
        return super.on(self, callbacks: callbacks)
    }
}

// MARK: UISlider

public extension UISlider {
    /**
        Attaches an event handler function for an event.
    
        :param: event A UIControlEvents event
    
        :param: callback The event handler function
        
        :returns: The slider
    */
    func on(event: UIControlEvents, _ callback: UISlider -> Void) -> UISlider {
        return super.on(self, event: event, callback: callback)
    }
    
    /**
        Attaches an event handler function for multiple events.
    
        :param: events An array of UIControlEvents
    
        :param: callback The event handler function
        
        :returns: The slider
    */
    func on(events: [UIControlEvents], _ callback: UISlider -> Void) -> UISlider {
        return super.on(self, events: events, callback: callback)
    }
    
    /**
        Attaches event handler functions for different events.
    
        :param: callbacks A dictionary with a UIControlEvents event as the key and an event handler function as the value
        
        :returns: The button
    */
    func on(callbacks: [UIControlEvents: UISlider -> Void]) -> UISlider {
        return super.on(self, callbacks: callbacks)
    }
}

// MARK: UIStepper

public extension UIStepper {
    /**
        Attaches an event handler function for an event.
    
        :param: event A UIControlEvents event
    
        :param: callback The event handler function
        
        :returns: The stepper
    */
    func on(event: UIControlEvents, _ callback: UIStepper -> Void) -> UIStepper {
        return super.on(self, event: event, callback: callback)
    }
    
    /**
        Attaches an event handler function for multiple events.
    
        :param: events An array of UIControlEvents
    
        :param: callback The event handler function
        
        :returns: The stepper
    */
    func on(events: [UIControlEvents], _ callback: UIStepper -> Void) -> UIStepper {
        return super.on(self, events: events, callback: callback)
    }
    
    /**
        Attaches event handler functions for different events.
    
        :param: callbacks A dictionary with a UIControlEvents event as the key and an event handler function as the value
        
        :returns: The button
    */
    func on(callbacks: [UIControlEvents: UIStepper -> Void]) -> UIStepper {
        return super.on(self, callbacks: callbacks)
    }
}

// MARK: UISwitch

public extension UISwitch {
    /**
        Attaches an event handler function for an event.
    
        :param: event A UIControlEvents event
    
        :param: callback The event handler function
        
        :returns: The switch
    */
    func on(event: UIControlEvents, _ callback: UISwitch -> Void) -> UISwitch {
        return super.on(self, event: event, callback: callback)
    }
    
    /**
        Attaches an event handler function for multiple events.
    
        :param: events An array of UIControlEvents
    
        :param: callback The event handler function
        
        :returns: The switch
    */
    func on(events: [UIControlEvents], _ callback: UISwitch -> Void) -> UISwitch {
        return super.on(self, events: events, callback: callback)
    }
    
    /**
        Attaches event handler functions for different events.
    
        :param: callbacks A dictionary with a UIControlEvents event as the key and an event handler function as the value
        
        :returns: The button
    */
    func on(callbacks: [UIControlEvents: UISwitch -> Void]) -> UISwitch {
        return super.on(self, callbacks: callbacks)
    }
}

// MARK: UITextField

public extension UITextField {
    /**
        Attaches an event handler function for an event.
    
        :param: event A UIControlEvents event
    
        :param: callback The event handler function
        
        :returns: The text field
    */
    func on(event: UIControlEvents, _ callback: UITextField -> Void) -> UITextField {
        return super.on(self, event: event, callback: callback)
    }
    
    /**
        Attaches an event handler function for multiple events.
    
        :param: events An array of UIControlEvents
    
        :param: callback The event handler function
        
        :returns: The text field
    */
    func on(events: [UIControlEvents], _ callback: UITextField -> Void) -> UITextField {
        return super.on(self, events: events, callback: callback)
    }
    
    /**
        Attaches event handler functions for different events.
    
        :param: callbacks A dictionary with a UIControlEvents event as the key and an event handler function as the value
        
        :returns: The button
    */
    func on(callbacks: [UIControlEvents: UITextField -> Void]) -> UITextField {
        return super.on(self, callbacks: callbacks)
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

private let proxies = NSMapTable.weakToStrongObjectsMapTable()

private class Proxy: NSObject {
    var actor: Triggerable!
    
    init(actor: Triggerable, control: UIControl, event: UIControlEvents) {
        super.init()
        
        self.actor = actor
        
        proxies.setObject(self, forKey: "\(control, event.rawValue)")
    }
    
    @objc func recognized(control: UIControl) {
        actor.trigger(control)
    }
}
