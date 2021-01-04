//
//  Log.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
class Log {
    
    var intFor : Int
    
    init() {
        intFor = 42
    }
    
    func DLog(message: String, function: String = #function) {
        #if DEBUG
        print("\(function): \(message)")
        #endif
    }
}

