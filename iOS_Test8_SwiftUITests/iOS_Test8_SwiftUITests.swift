//
//  iOS_Test8_SwiftUITests.swift
//  iOS_Test8_SwiftUITests
//
//  Created by Wei Sun on 2021/12/31.
//

import XCTest
//@testable import iOS_Test8_SwiftUI
@testable import Github_iOS_Test8_SwiftUI


class iOS_Test8_SwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testMockFailure() throws {
        XCTAssert(1 == 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
