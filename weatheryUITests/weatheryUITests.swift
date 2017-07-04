//
//  weatheryUITests.swift
//  weatheryUITests
//
//  Created by Henrik Akesson on 1/7/17.
//  Copyright © 2017 Henrik Akesson. All rights reserved.
//

import XCTest

class weatheryUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app.launchArguments.append("UI-TESTING")
        app.launchEnvironment["WeatherRequest0"] = "reply: { \"main\" : { \"humidity\" : 48, \"temp\" : 292.15 }, \"name\" : \"Helsinki\", \"clouds\" : { \"all\" : 20 }, \"wind\" : { \"speed\" : 4.6 } }"
        app.launchEnvironment["WeatherRequest1"] = "reply: { \"main\" : { \"humidity\" : 67, \"temp\" : 302.15 }, \"name\" : \"Madrid\", \"clouds\" : { \"all\" : 50 }, \"wind\" : { \"speed\" : 4.6 } }"
        app.launchEnvironment["WeatherRequest2"] = "error: Test error"

        app.launch()
    }
    
    func testLoadOK() {
        XCTAssertTrue(app.staticTexts["Helsinki"].exists)
        XCTAssertTrue(app.staticTexts["20%"].exists)
        XCTAssertTrue(app.staticTexts["4.6m/s"].exists)
        XCTAssertTrue(app.staticTexts["48%"].exists)
        //XCTAssertTrue(app.staticTexts["15°"].exists) the degree symbol breaks the test

        //by backgrounding and re-opening the app it reloads the data
        appToBackgroundAndForeground()

        XCTAssertTrue(app.staticTexts["Madrid"].exists)
        XCTAssertTrue(app.staticTexts["50%"].exists)
        XCTAssertTrue(app.staticTexts["4.6m/s"].exists)
        XCTAssertTrue(app.staticTexts["67%"].exists)

        //by backgrounding and re-opening the app it reloads the data
        appToBackgroundAndForeground()
        
        XCTAssertTrue(app.staticTexts["---"].exists)
        XCTAssertTrue(app.staticTexts["-"].exists)
        XCTAssertTrue(!app.staticTexts["Madrid"].exists)
        XCTAssertTrue(!app.staticTexts["50%"].exists)
        XCTAssertTrue(!app.staticTexts["4.6m/s"].exists)
        XCTAssertTrue(!app.staticTexts["67%"].exists)
        
        
    }
    
    private func appToBackgroundAndForeground() {
        XCUIDevice.shared().press(XCUIDeviceButton.home)
        Thread.sleep(forTimeInterval: 1.5)
        XCUIDevice.shared().siriService.activate(voiceRecognitionText: "Open weathery")
        Thread.sleep(forTimeInterval: 2.5)
    }
}
