//
//  StringTests.swift
//  weathery
//
//  Created by Henrik Akesson on 2/7/17.
//  Copyright © 2017 Henrik Akesson. All rights reserved.
//

import XCTest

class StringTests: XCTestCase {
    
    func testRemovePrefix() {
        let myString = "hohi"
        XCTAssertEqual("hi", myString.removingPrefix("ho"))
    }
    
    func testRemoveNonMatchingPrefix() {
        let myString = "hohi"
        XCTAssertNil(myString.removingPrefix("ko"))
    }

}
