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
import XCTest

// MARK: UIView

class TactileTests: XCTestCase {
    func _testLongPress() {
        testGesture(UILongPressGestureRecognizer.self)
        testShortHandMethod(UIView.longPress)
    }
    
    func _testPan() {
        testGesture(UIPanGestureRecognizer.self)
        testShortHandMethod(UIView.pan)
    }
    
    func _testPinch() {
        testGesture(UIPinchGestureRecognizer.self)
        testShortHandMethod(UIView.pinch)
    }
    
    func _testRotation() {
        testGesture(UIRotationGestureRecognizer.self)
        testShortHandMethod(UIView.rotation)
    }
    
    func _testSwipe() {
        testGesture(UISwipeGestureRecognizer.self)
        testShortHandMethod(UIView.swipe)
    }
    
    func _testTap() {
        testGesture(UITapGestureRecognizer.self)
        testShortHandMethod(UIView.tap)
    }
    
    func _testOff() {
        let view = UIView()
        let tap = UITapGestureRecognizer()
        view.on(tap, { print($0) })
        
        XCTAssertEqual(1, view.gestureRecognizers!.count)
        view.off(tap)
        XCTAssertEqual(0, view.gestureRecognizers!.count)
    }
    
    func _testOffWithGestureType() {
        let view = UIView()
        view.tap{ print($0) }.pinch{ print($0) }
        
        XCTAssertEqual(2, view.gestureRecognizers!.count)
        view.off(UITapGestureRecognizer.self)
        XCTAssertEqual(1, view.gestureRecognizers!.count)
        view.off(UIPinchGestureRecognizer.self)
        XCTAssertEqual(0, view.gestureRecognizers!.count)
        
        view.tap{print($0)}.swipe{$0}
        XCTAssertEqual(2, view.gestureRecognizers!.count)
        view.off()
        XCTAssertEqual(0, view.gestureRecognizers!.count)
    }
    
    func touchDown(button: UIButton) {
        print(button)
    }
    
    func _testUIControlEvents() {
        var triggered = false
        let button = UIButton()
        UIButton(frame: CGRect(origin: CGPointZero, size: CGSize(width: 200, height: 200)))
        
        button.on(.TouchDown) { button in
            triggered = true
        }
        
        // button.addTarget(self, action: "touchDown:", forControlEvents: .TouchDown)
        // button.sendActionsForControlEvents(.TouchDown)
        // println("done")
        
        // XCTAssert(triggered)
    }
    
    private func testShortHandMethod<T: UIGestureRecognizer>(method: UIView -> (T -> Void) -> UIView) {
        var argGesture: T?
        var triggered = false
        
        let view = UIView()
        
        method(view)({ arg in
            triggered = true
            argGesture = arg
        })

        let gesture = view.gestureRecognizers?.first as! T
        // let proxy = proxies.objectForKey(gesture) as! Proxy
        // proxy.recognized(gesture)
        
        XCTAssertTrue(triggered)
        XCTAssertNotNil(argGesture)
        XCTAssertEqual(argGesture!, gesture)
    }
    
    private func testGesture<T: UIGestureRecognizer>(gestureType: T.Type) {
        let view = UIView()
        let gesture = T()
        
        var argGesture: T?
        var triggered = false
        
        view.on(gesture) { arg in
            argGesture = arg
            triggered = true
        }
        
        // let proxy = proxies.objectForKey(gesture) as! Proxy
        // proxy.recognized(gesture)
        
        XCTAssertNotNil(argGesture)
        XCTAssertEqual(argGesture!, gesture)
        XCTAssertTrue(triggered)
        
        let button = UIButton()
        button.on(.TouchUpInside) { button in
            print(button)
        }
    }
}

// MARK: UIControl

extension TactileTests {}