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
extension UInt {
  @inlinable @inline(__always)
  internal var _firstSetBit: UInt? {
    guard self != 0 else { return nil }
    let v = UInt.bitWidth &- 1 &- self.leadingZeroBitCount
    return UInt(truncatingIfNeeded: v)
  }

  @inlinable @inline(__always)
  internal var _lastSetBit: UInt? {
    guard self != 0 else { return nil }
    return UInt(truncatingIfNeeded: self.trailingZeroBitCount)
  }
}
