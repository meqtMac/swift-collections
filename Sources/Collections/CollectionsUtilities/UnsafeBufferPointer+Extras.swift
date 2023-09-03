//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Collections open source project
//
// Copyright (c) 2021 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//






// In single module mode, we need these declarations to be internal,
// but in regular builds we want them to be public. Unfortunately
// the current best way to do this is to duplicate all definitions.
extension UnsafeBufferPointer {
  @inlinable
  @inline(__always)
  internal func _ptr(at index: Int) -> UnsafePointer<Element> {
    assert(index >= 0 && index < count)
    return baseAddress.unsafelyUnwrapped + index
  }
}
