//
//  DAManager.swift
//  DictionaryOfArrays
//
//  Created by Eric Kampman on 4/3/24.
//

import Foundation

class DAManager<K: Hashable, V: Identifiable> {
	private var storage = [K:[V]]()
	
	public func addKey(_ key: K) {
		if !keyExists(key) {
			storage[key] = [V]()
		}
	}
	
	public var keyCount: Int {
		return storage.count
	}
	
	public func valueCountForKey(_ key: K) -> Int {
		return storage[key]?.count ?? 0
	}

	public func keyExists(_ key: K) -> Bool {
		return nil != storage[key]
	}
	
	public func addValueForKey(_ key: K, value: V) {
		addKey(key)		// does nothing if already exists
		storage[key]!.append(value)
	}
	
	public func removeValueForKey(_ key: K, valueID: V.ID) {
		guard let index = storage[key, default: []].firstIndex(where: { $0.id == valueID} )
			else { return }
		
		storage[key, default: []].remove(at: index)
	}
	
	public func forEachValueInPlaceForKey(_ key: K, closure: (inout V) -> ()) {
		for i in 0..<valueCountForKey(key) {
			closure(&storage[key]![i])
		}
	}
	
	public func indicesForValuesOfKey(_ key: K, matching: (V) -> Bool) -> Set<Int> {
		var ret = Set<Int>()
		
		for i in 0..<valueCountForKey(key) {
			// won't get here if no values for key
			if matching(storage[key]![i]) {
				ret.insert(i)
			}
		}
		return ret
	}
}
