//
//  EditContactPresenter.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import CoreData

class EditContactPresenter : ContactPresenter {
    
    // MARK: - Instance properties
    var contact : Contact?
    
    // MARK: - EditContactPresenterProtocol Property Requirements
    
    var interactor : EditContactInteractorInputProtocol?
    
    var isPresenterReady: Bool = false
    
    var contactManagedObjectID : NSManagedObjectID
    
    var buttonTitle: String {return "Update Contact"}
    
    var firstNameTextFieldPlaceholder: String {return "Edit First Name"}
    
    var lastNameTextFieldPlaceholder: String {return "Edit Last Name"}
    
    var phoneTextFieldPlaceholder: String {return "Edit Phone"}
    
    var emailTextFieldPlaceholder: String {return "Edit Email"}
    
    var screenTitle : String {return "Edit Contact"}
    
    // MARK: - Initializer
    
    /// Initialize and create instance of the type 'EditContactPresenter'
    ///
    /// - Parameter managedObjectID: Object ID of the Contact managed object
    init(contact managedObjectID : NSManagedObjectID) {
        contactManagedObjectID = managedObjectID
    }
    
}

extension EditContactPresenter : EditContactPresenterProtocol {
    func proceedWitMOCUpdates() {
        print("proceed with MOC updates")
    }
    
    func showContactProfile() {
        print("show contact profile")
        view?.showIndicator()
        interactor?.fetch(contact: contactManagedObjectID)
    }
    
    func updateData() {
        print("update contact")
        
        let validation = validate()
        if validation.isValidated == true {
            print("it is to update contact")
        } else if let _error = validation.error {
            view?.validationFailed(withError: _error)
        }
    }
    
    func getFirstName() -> String? {
        return contact?.firstName
    }
    
    func getLastName() -> String? {
        return contact?.lastName
    }
    
    func getPhone() -> String? {
        return contact?.phone
    }
    
    func getEmail() -> String? {
        return contact?.email
    }
    
    func getQualification() -> String? {
        return contact?.qualification
    }
    
    func getNote() -> String? {
        return contact?.note
    }
}

extension EditContactPresenter : EditContactInteractorOutputProtocol {
    func didReceive(contact : Contact) {
        self.contact = contact
        print("received contact profile")
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideIndicator()
            self?.view?.readData()
        }
    }
    
    func receivedError(error: Error) {
        print("received error")
    }
}

