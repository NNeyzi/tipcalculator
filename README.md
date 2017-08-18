# Pre-work - Tipit

Tipit is a tip calculator application for iOS.

Submitted by: Nader Neyzi

Time spent: 2 hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are going to be implemented:
* [ ] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [ ] Improve UI.
- [ ] Implement auto-layout so the UI looks the same on all iphone sizes.
- [ ] Custom tip precentages.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/rvGOnYj.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** 
Loving iOS development. Xcode works great and is easy to use, clear documentation and big community online makes developing apps fun.

In Xcode there is a Storyboard file that provides a way to visually create your UI. It's where you can layout your UI objects like buttons and labels. IBAction and IBOutlet are ways you can connect the visual representations to your code. So you can reference them to create functions and properties. 

The Storyboard file is actually an XML file that gets rendered into visual representation in Xcode. So adding UI objects, IBActions and IBOutlets are added as XML elements into the file.


Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** 
Automatic Reference Counting deallocates objects with 0 strong references to them from memory.

A retain cycle is created when two objects have strong references to each other so neither can be deallocated. Compared to a garbage collector ARC doesn't deal with retain cycles itself. The developer needs to make sure none are created at run-time.

For closures, if a variable declared outside the closure is referenced inside the closure, a strong reference is created to that object. So if the variable inside the closure is an object that has a strong reference to the closure, this causes a strong reference cycle.

A common example is having a strong reference to self in a closure where by default self also has a strong reference to the closure. So to avoid this we need to use an 'unowned' reference to self in the closure.


## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
