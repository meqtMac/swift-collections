//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Collections open source project
//
// Copyright (c) 2022 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//






// In single module mode, we need these declarations to be internal,
// but in regular builds we want them to be public. Unfortunately
// the current best way to do this is to duplicate all definitions.
extension FixedWidthInteger {
  /// Round up `self` to the nearest power of two, assuming it's representable.
  /// Returns 0 if `self` isn't positive.
  @inlinable
  internal func _roundUpToPowerOfTwo() -> Self {
    guard self > 0 else { return 0 }
    let l = Self.bitWidth - (self &- 1).leadingZeroBitCount
    return 1 << l
  }
}
