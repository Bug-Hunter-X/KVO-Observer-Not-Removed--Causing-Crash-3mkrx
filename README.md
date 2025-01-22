# Objective-C KVO Memory Management Bug

This repository demonstrates a common, yet subtle, bug related to Key-Value Observing (KVO) in Objective-C.  Failure to properly remove observers leads to retain cycles and crashes, often manifesting long after the initial error.

## The Bug
The `KVORetainCycleBug.m` file contains code that illustrates this issue. A view controller observes a model object. When the view controller is deallocated, it fails to remove its KVO observer, resulting in a retain cycle. The observer holds a reference to the model, and the model (potentially through other properties) holds a reference to the view controller.  This prevents both objects from being deallocated.

## The Solution
The `KVORetainCycleSolution.m` file provides the corrected code.  The crucial change is the addition of code within the view controller's `dealloc` method to remove the KVO observer. This breaks the retain cycle, ensuring that the objects can be deallocated correctly.