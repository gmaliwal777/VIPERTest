//
//  ContactListInteractor.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import CoreData

class ContactListInteractor : BaseStorageCoordinator, ContactListInteractorInputProtocol {
    
    // MARK: - ContactListInteractorInputProtocol Property Requirements
    
    /// Reference to ContactList presenter unit
    weak var presenter : ContactListInteractorOutputProtocol?
    
    // MARK: - ContactListInteractorInputProtocol Method Requirements
    
    /// It fetched all the contacts from the database
    func retrieveContacts() {
        let managedObjectContext = self.managedObjectContext
        managedObjectContext.perform {
            
            let dbManager = DBManager.sharedManager
            let sortDescriptor = NSSortDescriptor(key: "creationTimestamp", ascending: true)
            dbManager.fetchEntities(Contact.entityName, sortDescriptors: [sortDescriptor], predicate: nil, managedObjectContext: managedObjectContext, completion: { [weak self] (_allContacts) in
                if let allContacts = _allContacts as? [Contact] {
                    print("number of contacts ---- \(allContacts.count)")
                    self?.presenter?.didReceive(contacts: allContacts)
                } else {
                    let error = Error(code: 1001, description: RealtorLiteral.emptyString, message: "No Contacts Available")
                    self?.presenter?.receivedError(error: error)
                }
            })
        }
    }
    
    func retrive(contacts contactsManagedObjecIds: [NSManagedObjectID]) {
        let managedObjectContext = self.managedObjectContext
        managedObjectContext.perform { [weak self] in
            
            let dbManager = DBManager.sharedManager
            dbManager.fetchEntity(withManagedObjectIDs: contactsManagedObjecIds, managedObjectContext: managedObjectContext, completion: { (managedObjects) in
                if let contacts = managedObjects as? [Contact] {
                     self?.presenter?.didReceive(contactsForRequestedManagedObjectIds: contacts)
                } else {
                    let error = Error(code: 1001, description: RealtorLiteral.emptyString, message: "Something went wrong")
                    self?.presenter?.receivedError(error: error)
                }
            })
        }
    }
    
    // MARK: - LifeCycle Methods
    
    override func handleAnotherMOCChangeEvent(notification: Notification) {
        super.handleAnotherMOCChangeEvent(notification: notification)
        
        // Here we consider received notification object parameter is MOC Notification.
        guard let mocNotification = notification.object as? Notification else {
            return
        }
        
        // Here we ignore if changes are from context associated MOC.
        let managedObjectContext = self.managedObjectContext
        guard let notificationManagedObjectContext = mocNotification.object as? NSManagedObjectContext, notificationManagedObjectContext != managedObjectContext else {
            return
        }
        
        managedObjectContext.perform { [weak self] in
            
            /// Interactor notify presenter using closure, if it find new contact managed object insertion in another MOC
            if let insertedObjects = mocNotification.userInfo?[NSInsertedObjectsKey] as? Set<NSManagedObject> , insertedObjects.isEmpty == false {
                var insertedContactIds = [NSManagedObjectID]()
                for managedObject in insertedObjects {
                    if let contactManagedObject = managedObject as? Contact {
                        managedObjectContext.mergeChanges(fromContextDidSave: notification)
                        insertedContactIds.append(contactManagedObject.objectID)
                    }
                }
                
                // Notifying to presenter for set of inserted contacts
                if insertedContactIds.isEmpty == false {
                    self?.presenter?.mocUpdated(withInsertedManagedObjects: insertedContactIds)
                    return
                }
                
            }
        }
    }
    
}
