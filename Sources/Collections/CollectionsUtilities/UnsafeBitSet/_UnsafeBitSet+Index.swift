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
extension _UnsafeBitSet {
  @frozen @usableFromInline
  internal struct Index: Comparable, Hashable {
    @usableFromInline
    internal typealias _Word = _UnsafeBitSet._Word

    @usableFromInline
    internal var value: UInt

    @inlinable
    internal init(_ value: UInt) {
      self.value = value
    }

    @inlinable
    internal init(_ value: Int) {
      self.value = UInt(value)
    }

    @inlinable
    internal init(word: Int, bit: UInt) {
      assert(word >= 0 && word <= Int.max / _Word.capacity)
      assert(bit < _Word.capacity)
      self.value = UInt(word &* _Word.capacity) &+ bit
    }
  }
}

extension _UnsafeBitSet.Index {
  @inlinable
  internal var word: Int {
    // Note: We perform on UInts to get faster unsigned math (shifts).
    Int(truncatingIfNeeded: value / UInt(bitPattern: _Word.capacity))
  }

  @inlinable
  internal var bit: UInt {
    // Note: We perform on UInts to get faster unsigned math (masking).
    value % UInt(bitPattern: _Word.capacity)
  }

  @inlinable
  internal var split: (word: Int, bit: UInt) {
    (word, bit)
  }

  @inlinable
  internal var endSplit: (word: Int, bit: UInt) {
    let w = word
    let b = bit
    if w > 0, b == 0 { return (w &- 1, UInt(_Word.capacity)) }
    return (w, b)
  }

  @inlinable
  internal static func ==(left: Self, right: Self) -> Bool {
    left.value == right.value
  }

  @inlinable
  internal static func <(left: Self, right: Self) -> Bool {
    left.value < right.value
  }

  @inlinable
  internal func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }

  @inlinable
  internal func _successor() -> Self {
    Self(value + 1)
  }

  @inlinable
  internal func _predecessor() -> Self {
    Self(value - 1)
  }
}
