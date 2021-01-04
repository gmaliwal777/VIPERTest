//
//  EditContactInteractor.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import CoreData

class EditContactInteractor : BaseStorageCoordinator , EditContactInteractorInputProtocol {
    
    // MARK: - EditContactInteractorInputProtocol Properties Requirements
    
    weak var presenter: EditContactInteractorOutputProtocol?
    
    // MARK: - EditContactInteractorInputProtocol Method Requirements
    
    func fetch(contact contactManagedObjectID: NSManagedObjectID) {
        
        let managedObjectContext = self.managedObjectContext
        managedObjectContext.perform { [weak self] in
            
            let dbmanager = DBManager.sharedManager
            dbmanager.fetchEntity(withManagedObjectID: contactManagedObjectID, managedObjectContext: managedObjectContext, completion: { (contactManagedObject) in
                if let _contactManagedObject = contactManagedObject as? Contact{
                    // Success
                    self?.presenter?.didReceive(contact: _contactManagedObject)
                } else {
                    // Failure
                    let error = Error(code: 1001, description: RealtorLiteral.emptyString, message: "No Contacts Available")
                    self?.presenter?.receivedError(error: error)
                }
            })
        }
    }
    
}
