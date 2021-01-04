//
//  AddContactInteractor.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import CoreData

class AddContactInteractor : BaseStorageCoordinator , AddContactInteractorInputProtocol {
    
    // MARK: - AddContactInteractorInputProtocol Requirements
    
    weak var presenter: AddContactInteractorOutputProtocol?
    
    func create(contact dataModel: ContactModel) {
        
        let managedObjectContext = self.managedObjectContext
        managedObjectContext.perform { [weak self] in
            
            let creationDateTime = Date()
            
            //Insertion in the contact entity
            
            if let contactEntity = NSEntityDescription.insertNewObject(forEntityName: Contact.entityName, into: managedObjectContext) as? Contact {
                contactEntity.firstName = dataModel.firstName
                contactEntity.lastName = dataModel.lastName
                contactEntity.phone = dataModel.phone
                contactEntity.email = dataModel.email
                contactEntity.qualification = dataModel.qualification
                contactEntity.note = dataModel.note
                contactEntity.creationTimestamp = creationDateTime
                contactEntity.updationTimestamp = creationDateTime
                
                let dbManager = DBManager.sharedManager
                // Pushing managed object context changes in database.
                dbManager.save(managedObjectContext: managedObjectContext, completion: { (executionStatus, wasMOCChanged) in
                    if executionStatus == wasMOCChanged {
                        do {
                            try managedObjectContext.obtainPermanentIDs(for: [contactEntity])
                        } catch {
                            print("Exception in getting permanent id of the new created contact record")
                        }
                        self?.presenter?.created(contact: contactEntity.objectID)
                    } else {
                        self?.presenter?.contactNotCreated()
                    }
                })
            } else {
                self?.presenter?.contactNotCreated()
            }
        }
    }
}

