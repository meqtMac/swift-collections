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
extension RandomAccessCollection {
  @_alwaysEmitIntoClient @inline(__always)
  internal func _index(at offset: Int) -> Index {
    index(startIndex, offsetBy: offset)
  }

  @_alwaysEmitIntoClient @inline(__always)
  internal func _offset(of index: Index) -> Int {
    distance(from: startIndex, to: index)
  }

  @_alwaysEmitIntoClient @inline(__always)
  internal subscript(_offset offset: Int) -> Element {
    self[_index(at: offset)]
  }
}
