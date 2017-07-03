//
//  String.swift
//  weathery
//
//  Created by Henrik Akesson on 2/7/17.
//  Copyright © 2017 Henrik Akesson. All rights reserved.
//

import Foundation

extension String {
    func removingPrefix(_ prefix: String) -> String? {
        guard self.hasPrefix(prefix) else { return nil }
        let index = self.index(self.startIndex, offsetBy: prefix.characters.count)
        return self.substring(from: index)
    }
}
