//
//  StringExt.swift
//  Circle
//
//  Created by Ivanna Peña on 5/3/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let lastpart = "nyu.edu"
        let emailRegex = firstpart + "@" + lastpart
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}

extension UITextField {
    func isValidEmail() -> Bool {
        return self.text!.isValidEmail()
    }
}
