//
//  Structs.swift
//  VIPERDemo
//
//  Created by Macmini on 10/5/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import CoreData

struct MOCEvent {
    /// flag says whether change happened or not in MOC (managed object context)
    var flag = false {
        didSet {
            if flag == true {
                occurrences += 1
            } else {
                occurrences = 0
            }
        }
    }
    
    /// It says that How many times a particular change (Insert, Update, Delete) happened.
    var occurrences = 0
    
    /// Reference to managed object which was affected (updated/inserted/deleted)
    var affectedManagedObjectIds : [NSManagedObjectID]?
    
    /// It indicates type of the MOC event(updated/inserted/deleted)
    let eventType : MOCEventType
    
    // MARK: - Initializers
    
    /// Initializer to instantiate MOCEvent instance
    ///
    /// - Parameter eType: event type(updated/inserted/deleted).
    init(type eType: MOCEventType) {
        self.eventType = eType
    }
}

struct PhoneAndZipConstants{
    
    static let maximumZipcodeLength : Int = 5
    static let maximumLengthOfPhoneNumber :Int = 10
    static let acceptableNumbers : String = "1234567890"
}

struct RealtorLiteral {
    static let emptyString = ""
}

