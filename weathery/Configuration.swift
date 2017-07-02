//
//  Configuration.swift
//  weathery
//
//  Created by Henrik Akesson on 2/7/17.
//  Copyright © 2017 Henrik Akesson. All rights reserved.
//

import Foundation

struct Configuration {

    static var isUITesting: Bool {
        return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
    }
    
    static func uiTest(variable: String) -> String? {
        return ProcessInfo.processInfo.environment[variable]
    }
}
