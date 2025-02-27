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

@usableFromInline
internal func _addressString(for pointer: UnsafeRawPointer) -> String {
    let address = UInt(bitPattern: pointer)
    return "0x\(String(address, radix: 16))"
}

@usableFromInline
internal func _addressString(for object: AnyObject) -> String {
    _addressString(for: Unmanaged.passUnretained(object).toOpaque())
}

@usableFromInline
internal func _addressString<T: AnyObject>(for object: Unmanaged<T>) -> String {
    _addressString(for: object.toOpaque())
}

@inlinable
internal func _arrayDescription<C: Collection>(
    for elements: C
) -> String {
    var result = "["
    var first = true
    for item in elements {
        if first {
            first = false
        } else {
            result += ", "
        }
        debugPrint(item, terminator: "", to: &result)
    }
    result += "]"
    return result
}

@inlinable
internal func _dictionaryDescription<Key, Value, C: Collection>(
    for elements: C
) -> String where C.Element == (key: Key, value: Value) {
    guard !elements.isEmpty else { return "[:]" }
    var result = "["
    var first = true
    for (key, value) in elements {
        if first {
            first = false
        } else {
            result += ", "
        }
        debugPrint(key, terminator: "", to: &result)
        result += ": "
        debugPrint(value, terminator: "", to: &result)
    }
    result += "]"
    return result
}
