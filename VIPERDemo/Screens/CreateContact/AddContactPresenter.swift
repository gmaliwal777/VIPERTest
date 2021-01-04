//
//  AddContactPresenter.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import CoreData

class AddContactPresenter : ContactPresenter {
    
    // MARK: - AddContactPresenterProtocol Property Requirements
    
    /// Reference to AddContact interactor
    var interactor : AddContactInteractorInputProtocol?
    
    var buttonTitle: String {return "Add Contact"}
    
    var firstNameTextFieldPlaceholder: String {return "Enter First Name"}
    
    var lastNameTextFieldPlaceholder: String {return "Enter Last Name"}
    
    var phoneTextFieldPlaceholder: String {return "Enter Phone"}
    
    var emailTextFieldPlaceholder: String {return "Enter Email"}
    
    var screenTitle : String {return "Add Contact"}
    
}

extension AddContactPresenter : AddContactPresenterProtocol {
    func updateData() {
        print("create contact")
        
        let validation = validate()
        if validation.isValidated == true {
            print("it is to create contact")
            if let _interactor = interactor {
                view?.showIndicator()
                guard let firstName = self.firstName.trimmedValue(), let lastName = self.lastName.trimmedValue(), let phone = self.phone.trimmedValue(), let email = self.phone.trimmedValue() else {
                    return
                }
                let qualification = self.qualification.trimmedValue()
                let note = self.note.trimmedValue()
                let contactDataModel = ContactModel(firstName: firstName, lastName: lastName, phone: phone, email: email, qualification: qualification,note : note)
                _interactor.create(contact: contactDataModel)
            }
        } else if let _error = validation.error {
            view?.validationFailed(withError: _error)
        }
    }
}

extension AddContactPresenter : AddContactInteractorOutputProtocol {
    func created(contact managedObjectID: NSManagedObjectID) {
        print("contact is created")
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.created(contact: managedObjectID)
            self?.view?.hideIndicator()
        }
    }
    
    func contactNotCreated() {
        print("contact creation is failed")
        DispatchQueue.main.async { [weak self] in
            let error = Error(code: 1001, description: RealtorLiteral.emptyString, message: "Something went wrong please try again later")
            self?.view?.showError(error: error)
            self?.view?.hideIndicator()
        }
    }
}
