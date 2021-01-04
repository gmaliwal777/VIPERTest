//
//  BaseReadablePresenter.swift
//  VIPERDemo
//
//  Created by Macmini on 10/5/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation

class BaseReadablePresenter {
    
    // MARK: - Instance Properties
    
    /// It says whether or not presenter received any updation event for one of the object managed by MOC
    var mocUpdationEvent = MOCEvent(type: MOCEventType.updated)
    
    /// It says whether or not presenter received any insertion event for MOC
    var mocInsertionEvent = MOCEvent(type: MOCEventType.inserted)
    
    /// It says whether or not presenter received any deletion event for one of the object managed by MOC
    var mocDeletionEvent = MOCEvent(type: MOCEventType.deleted)
    
    // MARK: - Instance Methods
    /// It reset reference which looks for the MOC events (updation, insertion and deletion)
    func resetMOCChangeEvents() {
        mocUpdationEvent.flag = false
        mocUpdationEvent.affectedManagedObjectIds = nil
        
        mocInsertionEvent.flag = false
        mocInsertionEvent.affectedManagedObjectIds = nil
        
        mocDeletionEvent.flag = false
        mocDeletionEvent.affectedManagedObjectIds = nil
    }
}
