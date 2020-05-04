//
//  String+CurrentTimeInMilliSeconds.swift
//  Circle
//
//  Created by Ivanna Peña on 5/4/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func currentTimeInMilliSeconds() -> Int64 {
        let nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble * 1000)
    }
}
