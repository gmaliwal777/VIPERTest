//
//  BaseStorageCoordinator.swift
//  GoFigure
//
//  Created by Cybage on 11/28/18.
//  Copyright © 2018 C. All rights reserved.
//

import Foundation
import CoreData

class BaseStorageCoordinator {
    
    // MARK: - Instance Properties
    
    /// Managed object context which interacts with database for JOB creation.
    lazy var managedObjectContext : NSManagedObjectContext = {
        let dbManager = DBManager.sharedManager
        return dbManager.temporaryMOC()
    }()
    
    
    // MARK: - Initializers
    
    
    /// Initializer
    init() {
        _ = managedObjectContext
        NotificationCenter.default.addObserver(self, selector: #selector(handleContextDidSaveEvent(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: managedObjectContext)
        NotificationCenter.default.addObserver(self, selector: #selector(handleAnotherMOCChangeEvent(notification:)), name: NSNotification.Name(rawValue: RealtorNotificationIdentifier.managedObjectsContextDidChangeNotificationIdentiifer), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Instance Methods
    
    /// Sub-class should not override it, doing it may create standstill situation for you.
    /// - Parameter notification: Notification
    @objc func handleContextDidSaveEvent(notification: Notification) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: RealtorNotificationIdentifier.managedObjectsContextDidChangeNotificationIdentiifer), object: notification)
    }
    
    /// Sub-class can override this behavior to provide implementation to respond to another MOC change event notification.
    /// - Parameter notification: Notification
    @objc func handleAnotherMOCChangeEvent(notification: Notification) {}
    
    
    
    /// It refresh managed object context and sync with persistent storage.
    func refreshContext(completionHandler handler : @escaping () -> Void) {
        let _managedObjectContext = managedObjectContext
        _managedObjectContext.performAndWait {
            managedObjectContext.refreshAllObjects()
            handler()
        }
    }
    
    /// It refresh specified managed object only not entire managed object context.
    func refreshContext(forManagedObject managedObject : NSManagedObject, completionHandler handler : @escaping () -> Void) {
        let _managedObjectContext = managedObjectContext
        _managedObjectContext.performAndWait {
            managedObjectContext.refresh(managedObject, mergeChanges: true)
            handler()
        }
    }
    
    /// It performs asyncronous execution of managed object context task
    ///
    /// - Parameter block: Execution block
    func performExecutionAsynchronously(block : @escaping () -> Void ) {
        let _managedObjectContext = managedObjectContext
        _managedObjectContext.perform {
            block()
        }
    }
    
    /// It performs syncronous execution of managed object context task
    ///
    /// - Parameter block: Execution block
    func performExecutionSynchronously(block : @escaping () -> Void ) {
        let _managedObjectContext = managedObjectContext
        _managedObjectContext.performAndWait {
            block()
        }
    }
}
