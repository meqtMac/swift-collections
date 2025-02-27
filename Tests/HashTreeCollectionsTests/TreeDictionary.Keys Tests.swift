//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Collections open source project
//
// Copyright (c) 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import XCTest
import Collections
import _CollectionsTestSupport

class TreeDictionaryKeysTests: CollectionTestCase {
  func test_BidirectionalCollection_fixtures() {
    withEachFixture { fixture in
      withLifetimeTracking { tracker in
        let (d, ref) = tracker.shareableDictionary(for: fixture)
        let k = ref.map { $0.key }
        checkCollection(d.keys, expectedContents: k, by: ==)
        _checkBidirectionalCollection_indexOffsetBy(
          d.keys, expectedContents: k, by: ==)
      }
    }
  }

  func test_descriptions() {
    let d: TreeDictionary = [
      "a": 1,
      "b": 2
    ]

    if d.first!.key == "a" {
      expectEqual(d.keys.description, #"["a", "b"]"#)
      expectEqual(d.keys.debugDescription, #"["a", "b"]"#)
    } else {
      expectEqual(d.keys.description, #"["b", "a"]"#)
      expectEqual(d.keys.debugDescription, #"["b", "a"]"#)
    }
  }

  func test_contains() {
    withEverySubset("a", of: testItems) { a in
      let x = TreeDictionary<RawCollider, Int>(
        uniqueKeysWithValues: a.lazy.map { ($0, 2 * $0.identity) })
      let u = Set(a)

      func checkSequence<S: Sequence>(
        _ items: S,
        _ value: S.Element
      ) -> Bool
      where S.Element: Equatable {
        items.contains(value)
      }

      withEvery("key", in: testItems) { key in
        expectEqual(x.keys.contains(key), u.contains(key))
        expectEqual(checkSequence(x.keys, key), u.contains(key))
      }
    }
  }

  func test_intersection_exhaustive() {
    withEverySubset("a", of: testItems) { a in
      let x = TreeDictionary<RawCollider, Int>(
        uniqueKeysWithValues: a.lazy.map { ($0, 2 * $0.identity) })
      let u = Set(a)
      expectEqualSets(x.keys.intersection(x.keys), u)
      withEverySubset("b", of: testItems) { b in
        let y = TreeDictionary<RawCollider, Int>(
          uniqueKeysWithValues: b.lazy.map { ($0, -$0.identity - 1) })
        let v = Set(b)
        let z = TreeSet(b)

        let reference = u.intersection(v)

        expectEqualSets(x.keys.intersection(y.keys), reference)
        expectEqualSets(x.keys.intersection(z), reference)
      }
    }
  }

  func test_subtracting_exhaustive() {
    withEverySubset("a", of: testItems) { a in
      let x = TreeDictionary<RawCollider, Int>(
        uniqueKeysWithValues: a.lazy.map { ($0, 2 * $0.identity) })
      let u = Set(a)
      expectEqualSets(x.keys.subtracting(x.keys), [])
      withEverySubset("b", of: testItems) { b in
        let y = TreeDictionary<RawCollider, Int>(
          uniqueKeysWithValues: b.lazy.map { ($0, -$0.identity - 1) })
        let v = Set(b)
        let z = TreeSet(b)

        let reference = u.subtracting(v)

        expectEqualSets(x.keys.subtracting(y.keys), reference)
        expectEqualSets(x.keys.subtracting(z), reference)
      }
    }
  }

}
