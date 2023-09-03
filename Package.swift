// swift-tools-version:5.6
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Collections open source project
//
// Copyright (c) 2021-2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import PackageDescription
enum SwiftFlags: String {
    // Enables internal consistency checks at the end of initializers and
    // mutating operations. This can have very significant overhead, so enabling
    // this setting invalidates all documented performance guarantees.
    //
    // This is mostly useful while debugging an issue with the implementation of
    // the hash table itself. This setting should never be enabled in production
    // code.
    case internalChecks =  "COLLECTIONS_INTERNAL_CHECKS"
   
    // Enables randomized testing of some data structure implementations.
    case randomizedTesting = "COLLECTIONS_RANDOMIZED_TESTING"
    
    // Hashing collections provided by this package usually seed their hash
    // function with the address of the memory location of their storage,
    // to prevent some common hash table merge/copy operations from regressing to
    // quadratic behavior. This setting turns off this mechanism, seeding
    // the hash function with the table's size instead.
    //
    // When used in conjunction with the SWIFT_DETERMINISTIC_HASHING environment
    // variable, this enables reproducible hashing behavior.
    //
    // This is mostly useful while debugging an issue with the implementation of
    // the hash table itself. This setting should never be enabled in production
    // code.
    case deterministicHashing = "COLLECTIONS_DETERMINISTIC_HASHING"
}

var _settings: [SwiftFlags] = [
    .randomizedTesting
]

let package = Package(
    name: "swift-collections",
    products:  [
        .library(name: "Collections", targets: ["Collections"])
    ] ,
    targets: [
        .target(
            name: "_CollectionsTestSupport",
            dependencies: ["Collections"],
            path: "Tests/_CollectionsTestSupport"
        ),
        .testTarget(
            name: "CollectionsTestSupportTests",
            dependencies: ["_CollectionsTestSupport"]),
        .testTarget(
            name: "BitCollectionsTests",
            dependencies: ["_CollectionsTestSupport"]),
        .testTarget(
            name: "DequeTests",
            dependencies: ["_CollectionsTestSupport"]),
        .testTarget(
            name: "HashTreeCollectionsTests",
            dependencies: ["_CollectionsTestSupport"]),
        .testTarget(
            name: "HeapTests",
            dependencies: ["_CollectionsTestSupport"]),
        .testTarget(
            name: "OrderedCollectionsTests",
            dependencies: ["_CollectionsTestSupport"]),
        .testTarget(
            name: "RopeModuleTests",
            dependencies: ["_CollectionsTestSupport"]),
        .target(
            name: "Collections",
            swiftSettings: _settings.map { .define($0.rawValue) }
        )
    ]
)

