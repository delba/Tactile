<p align="center">
  <img src="https://github.com/delba/Tactile/blob/assets/master%402x.png" />
</p>

<p align="center">
  <a href="https://travis-ci.org/delba/Tactile"><img alt="Travis Status" src="https://img.shields.io/travis/delba/Tactile.svg"/></a>
  <a href="https://img.shields.io/cocoapods/v/Tactile.svg"><img alt="CocoaPods compatible" src="https://img.shields.io/cocoapods/v/Tactile.svg"/></a>
  <a href="https://github.com/Carthage/Carthage"><img alt="Carthage compatible" src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg"/></a>
</p>

**Tactile** is a safer and more idiomatic way to respond to gestures and control events. It lets you catch bugs at compile time and write more expressive code.

```swift
view.pan([
    .began:   panBegan,
    .changed: panChanged,
    .ended:   panEnded
])

// func panBegan(pan: UIPanGestureRecognizer)
// func panChanged(pan: UIPanGestureRecognizer)
// func panEnded(pan: UIPanGestureRecognizer)
```

<p align="center">
  <a href="#usage">Usage</a> • <a href="#installation">Installation</a> • <a href="#license">License</a>
</p>

## Usage

**Tactile** extends both [`UIView`](https://github.com/delba/Tactile#uiview-extensions) and [`UIControl`](https://github.com/delba/Tactile#uicontrol-extensions) classes.

### UIView extensions
[`UIView+Tactile.swift`](https://github.com/delba/Tactile/blob/master/Source/UIView%2BTactile.swift)

#### The `on` method

Use the `on` method to add gesture recognizers.

**`on(gesture:callback:)`**

```swift
let tap = UITapGestureRecognizer()
tap.numberOfTapsRequired = 3
tap.numberOfTouchesRequired = 2

view.on(tap, tapped)

// func tapped(tap: UITapGestureRecognizer)
```

**`on(gesture:state:callback:)`**

```swift
let pinch = UIPinchGestureRecognizer()

view.on(pinch, .began, pinchBegan)

// func pinchBegan(pinch: UIPinchGestureRecognizer)
```

**`on(gesture:states:callback:)`**

```swift
let pan = UIPanGestureRecognizer()

view.on(pan, [.began, .ended], panBeganOrEnded)

// func panBeganOrEnded(pan: UIPanGestureRecognizer)
```

**`on(gesture:callbacks:)`**

```swift
let pinch = UIPinchGestureRecognizer()

view.on(pinch, [
  .began: pinchBegan,
  .ended: pinchEnded
])

// func pinchBegan(pinch: UIPinchGestureRecognizer)
// func pinchEnded(pinch: UIPinchGestureRecognizer)
```

#### The shorthand methods

**Tactile** defines 6 shorthand methods: `longPress`, `pan`, `pinch`, `rotation`, `swipe` and `tap`.

**`<shorthand>(callback:)`**

```swift
view.tap(tapped)

// func tapped(tap: UITapGestureRecognizer)
```

**`<shorthand>(state:callback:)`**

```swift
view.pinch(.began, pinchBegan)

// func pinchBegan(pinch: UIPinchGestureRecognizer)
```

**`<shorthand>(states:callback:)`**

```swift
view.pan([.began, .ended], panBeganOrEnded)

// func panBeganOrEnded(pan: UIPanGestureRecognizer)
```

**`<shorthand>(callbacks:)`**

```swift
view.longPress([
  .began: longPressBegan,
  .ended: longPressEnded
])

// func longPressBegan(longPress: UILongPressGestureRecognizer)
// func longPressEnded(longPress: UILongPressGestureRecognizer)
```

#### The `off` method

Use the `off` method to remove gesture recognizers.

**`off(gesture:)`**

```swift
let tap = UITapGestureRecognizer()
view.on(tap, tapped)

// ...

view.off(tap)
```

**`off(gestureType:)`**

```swift
view.off(UITapGestureRecognizer.self)
```

**`off()`**

```swift
view.off()
```

#### Attaching a gesture recognizer to multiple views

With Tactile, you can attach the same gesture recognizer to multiple views.

```swift
let tap = UITapGestureRecognizer()
tap.numberOfTapsRequired = 3
tap.numberOfTouchesRequired = 2

firstView.on(tap, firstViewTapped)
secondView.on(tap, secondViewTapped)
```

### UIControl extensions
[`UIControl+Tactile.swift`](https://github.com/delba/Tactile/blob/master/Source/UIControl%2BTactile.swift)

Use the `on` method to attach an event handler function for one or more control events.

**on(event:callback:)**

```swift
button.on(.touchUpInside, tapped)

// func tapped(button: UIButton)
```

**on(events:callback:)**

```swift
button.on([.touchUpInside, .touchUpOutside], tapped)

// func tapped(button: UIButton)
```

**on(callbacks:)**

```swift
button.on([
  .touchUpInside: tapped,
  .touchUpOutside: cancelledTap
])

// func tapped(button: UIButton)
// func cancelledTap(button: UIButton)
```

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Tactile into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "delba/Tactile" >= 1.0
```

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Tactile into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'Tactile', '~> 1.0'
```

## License

Copyright (c) 2015-2019 Damien (http://delba.io)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
