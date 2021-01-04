//
//  ContactListPresenter.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import CoreData

class ContactListPresenter : BaseReadablePresenter {
    
    // MARK: - Instance Properties
    
    /// Reference to the contacts collection
    var allContacts: [Contact]?
    
    // MARK: - ContactListPresenterProtocol Requirements
    
    /// Reference to contact-list view part
    weak var view: ContactListViewProtocol?
    
    /// Reference to contact-list router unit
    var router: ContactListRouterProtocol?
    
    /// Reference to ContactList interactor unit
    var interactor : ContactListInteractorInputProtocol?
    
    var isPresenterReady: Bool = false
    
    // MARK: - Instance Methods
    
    private func delete(contacts contactsManagedObjects : [Contact]) {
        
    }
    
}

extension ContactListPresenter : ContactListPresenterProtocol {
    
    func createNewContact() {
        print("ask router part to display \"Add Contact\" module ")
        if let contactListViewController = view as? ContactListViewController, let contactViewController = router?.createAddContactModule() {
            contactListViewController.navigationController?.pushViewController(contactViewController, animated: true)
        }
    }
    
    func updateContact(atIndex index: Int) {
        var contact : Contact?
        if let contactListInteractor = interactor as? BaseStorageCoordinator {
            contactListInteractor.performExecutionSynchronously { [weak self] in
                if let _allContacts = self?.allContacts, _allContacts.count > index {
                    contact = _allContacts[index]
                }
            }
        }
        if let _contact = contact {
            if let contactListViewController = view as? ContactListViewController, let contactViewController = router?.createEditContactModule(forContact: _contact.objectID) {
                contactListViewController.navigationController?.pushViewController(contactViewController, animated: true)
            }
        }
    }
    
    /// View ask presenter whether it has any MOC event or not
    ///
    /// - Returns: MOCEvent object
    func proceedWitMOCUpdates() {
        print("is there any MOC event")
        if mocInsertionEvent.flag == false && mocDeletionEvent.flag == false && mocUpdationEvent.flag == false {
            return
        }
        
        view?.showIndicator()
        let selfContext = self
        DispatchQueue.global().async {
            if (selfContext.mocInsertionEvent.flag == true && selfContext.mocDeletionEvent.flag == true) ||
                ( selfContext.mocDeletionEvent.flag == true && selfContext.mocUpdationEvent.flag == true) ||
                ( selfContext.mocInsertionEvent.flag == true && selfContext.mocUpdationEvent.flag == true) {
                selfContext.interactor?.retrieveContacts()
            } else if selfContext.mocInsertionEvent.flag == true {
                // Insert event
                if let newInsertedManagedObjectIds = selfContext.mocInsertionEvent.affectedManagedObjectIds {
                    selfContext.interactor?.retrive(contacts: newInsertedManagedObjectIds)
                }
            } else if selfContext.mocUpdationEvent.flag == true {
                // Update event
            } else if selfContext.mocDeletionEvent.flag == true {
                // Delete event
            }
        }
    }
    
    func viewDismissed() {
        print("view is about to dismiss")
    }
    
    /// View ask presenter to show up all the contacts
    func showContacts() {
        print("show all the contacts")
        view?.showIndicator()
        interactor?.retrieveContacts()
    }
    
    /// It tells about the number of contacts
    ///
    /// - Returns: Number of contacts.
    func numberOfContacts() -> Int {
        var numberOfContacts = 0
        
        if let contactListInteractor = interactor as? BaseStorageCoordinator {
            contactListInteractor.performExecutionSynchronously { [weak self] in
                if let _allContacts = self?.allContacts {
                    numberOfContacts = _allContacts.count
                }
            }
        }
        return numberOfContacts
    }
    
    
    /// It returns a full name after creating it with frist-name and last-name.
    ///
    /// - Parameter index: Index of the contact
    func nameOfContact(atIndex index:Int) -> String {
        var fullName = ""
        if let contactListInteractor = interactor as? BaseStorageCoordinator {
            contactListInteractor.performExecutionSynchronously { [weak self] in
                if let _allContacts = self?.allContacts, _allContacts.count > index {
                    let contact = _allContacts[index]
                    let firstName = contact.firstName
                    let lastName = contact.lastName
                    fullName = "\(firstName) \(lastName)"
                }
            }
        }
        return fullName
    }
    
    /// It returns contact phone number
    ///
    /// - Parameter index: Index of the contact
    func phoneOfContact(atIndex index:Int) -> String {
        var phone = ""
        if let contactListInteractor = interactor as? BaseStorageCoordinator {
            contactListInteractor.performExecutionSynchronously { [weak self] in
                if let _allContacts = self?.allContacts, _allContacts.count > index {
                    let contact = _allContacts[index]
                    phone = contact.phone
                }
            }
        }
        return phone
    }
}

extension ContactListPresenter : ContactListInteractorOutputProtocol {
    func mocUpdated(withEditedManagedObjects editedManagedObjectIds: [NSManagedObjectID]) {
        mocUpdationEvent.flag = true
        if let previousUpdatedManagedObjectIds = mocUpdationEvent.affectedManagedObjectIds {
            // Adding more along with existing updated managed objects
            for editedManagedObjectID in editedManagedObjectIds {
                let collection = previousUpdatedManagedObjectIds.filter({ (existingUpdatedManagedObjectID) -> Bool in
                    return existingUpdatedManagedObjectID == editedManagedObjectID
                })
                if collection.count == 0 {
                    mocUpdationEvent.affectedManagedObjectIds?.append(editedManagedObjectID)
                }
            }
        } else {
            mocUpdationEvent.affectedManagedObjectIds = editedManagedObjectIds
        }
        
        // Notifying view part about the MOC update
        view?.updatesReceived()
    }
    
    func mocUpdated(withInsertedManagedObjects insertedManagedObjectIds: [NSManagedObjectID]) {
        print("here it is moc insertion event")
        mocInsertionEvent.flag = true
        if mocInsertionEvent.affectedManagedObjectIds != nil {
            // Adding more along with existing inserted managed objects
            for insertedManagedObjectID in insertedManagedObjectIds {
                mocInsertionEvent.affectedManagedObjectIds?.append(insertedManagedObjectID)
            }
        } else {
            mocInsertionEvent.affectedManagedObjectIds = insertedManagedObjectIds
        }
        
        // Notifying view part about the MOC update
        view?.updatesReceived()
    }
    
    func mocUpdated(withDeletedManagedObjects deletedManagedObjectIds: [NSManagedObjectID]) {
        mocDeletionEvent.flag = true
        if mocDeletionEvent.affectedManagedObjectIds != nil {
            // Adding more along with existing inserted managed objects
            for deletedManagedObject in deletedManagedObjectIds {
                mocDeletionEvent.affectedManagedObjectIds?.append(deletedManagedObject)
            }
        } else {
            mocDeletionEvent.affectedManagedObjectIds = deletedManagedObjectIds
        }
        
        // Notifying view part about the MOC update
        view?.updatesReceived()
    }
    
    func didReceive(contacts: [Contact]) {
        print("did receive data")
        allContacts = contacts
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideIndicator()
            self?.view?.readData()
        }
    }
    
    func didReceive(contactsForRequestedManagedObjectIds : [Contact]) {
        print("did receive new contacts --- \(contactsForRequestedManagedObjectIds.count)")
        allContacts?.insert(contentsOf: contactsForRequestedManagedObjectIds, at: 0)
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideIndicator()
            self?.view?.insertContacts(atIndexes: [0])
        }
    }
    
    func receivedError(error: Error) {
        print("received error")
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideIndicator()
            self?.view?.showError(error: error)
        }
    }
}
