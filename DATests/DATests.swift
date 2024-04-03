//
//  DATests.swift
//  DATests
//
//  Created by Eric Kampman on 4/3/24.
//

import XCTest

class TestValue: Identifiable {
	var id: String
	var date: Date

	init(id: String, date: Date) {
		self.id = id
		self.date = date
	}
}

let kevinGilbert = "Kevin Gilbert"
let toddRundgren = "Todd Rundgren"
let jemGodfrey = "Jem Godfrey"

let guitar = "guitar"
let rhodes = "rhodes"
let synth = "synth"

let guitarValue = TestValue(id: guitar, date: Date.distantPast)
let synthValue = TestValue(id: synth, date: Date.distantPast)
let rhodesValue = TestValue(id: rhodes, date: Date.distantPast)

final class DATests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDA() throws {
        let daManager = DAManager<String, TestValue>()
		
		daManager.addKey(kevinGilbert)
		daManager.addKey(toddRundgren)
		daManager.addKey(jemGodfrey)
		
		daManager.addValueForKey(kevinGilbert, value: guitarValue)
		daManager.addValueForKey(kevinGilbert, value: synthValue)

		daManager.addValueForKey(toddRundgren, value: guitarValue)
		daManager.addValueForKey(toddRundgren, value: rhodesValue)	// don't actually know if he has one

		daManager.addValueForKey(jemGodfrey, value: synthValue)
		daManager.addValueForKey(jemGodfrey, value: rhodesValue)

		XCTAssert(daManager.keyCount == 3)
		XCTAssert(daManager.valueCountForKey(kevinGilbert) == 2)
		XCTAssert(daManager.valueCountForKey(toddRundgren) == 2)
		XCTAssert(daManager.valueCountForKey(jemGodfrey) == 2)

		daManager.removeValueForKey(kevinGilbert, valueID: guitar)
		XCTAssert(daManager.valueCountForKey(kevinGilbert) == 1)
    }
	
	func testForEachItemInPlace() throws {
		let daManager = DAManager<String, TestValue>()
		
		daManager.addKey(kevinGilbert)
		daManager.addKey(toddRundgren)

		daManager.addValueForKey(toddRundgren, value: guitarValue)
		daManager.addValueForKey(toddRundgren, value: rhodesValue)

		let currentDate = Date()
		daManager.forEachValueInPlaceForKey(toddRundgren) { value in
			let value = value as TestValue
			value.date = currentDate
		}
		
		let matchingIndices = daManager.indicesForValuesOfKey(toddRundgren) { value in
			let value = value as TestValue
			return value.date == currentDate
		}
		
		XCTAssert(matchingIndices.count == 2)
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
