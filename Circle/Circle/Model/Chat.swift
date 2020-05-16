//
//  Chat.swift
//  Circle
//
//  Created by Ivanna Peña on 5/16/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import Foundation

class Chat {
    
    private var _key: String
    private var _members: [String]

  
    var key: String {
        return _key
    }
    
    var members: [String] {
        return _members
    }
    
    init(key: String, members: [String]) {
        self._key = key
        self._members = members
    }
}
