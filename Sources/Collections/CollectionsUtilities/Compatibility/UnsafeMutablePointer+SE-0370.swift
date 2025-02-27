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
#if swift(<5.8)
extension UnsafeMutablePointer {
  /// Update this pointer's initialized memory with the specified number of
  /// consecutive copies of the given value.
  ///
  /// The region of memory starting at this pointer and covering `count`
  /// instances of the pointer's `Pointee` type must be initialized or
  /// `Pointee` must be a trivial type. After calling
  /// `update(repeating:count:)`, the region is initialized.
  ///
  /// - Parameters:
  ///   - repeatedValue: The value used when updating this pointer's memory.
  ///   - count: The number of consecutive elements to update.
  ///     `count` must not be negative.
  @_alwaysEmitIntoClient
  internal func update(repeating repeatedValue: Pointee, count: Int) {
    assert(count >= 0, "UnsafeMutablePointer.update(repeating:count:) with negative count")
    for i in 0 ..< count {
      self[i] = repeatedValue
    }
  }
}
#endif
