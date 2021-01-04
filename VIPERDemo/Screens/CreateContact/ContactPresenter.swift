//
//  ContactPresenter.swift
//  VIPERDemo
//
//  Created by Macmini on 10/21/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation

class ContactPresenter {
    
    // MARK: - AddContactPresenterProtocol Requirements
    
    /// FirstName observable
    let firstName : Observable<String> = Observable()
    
    /// Last Name observalbe.
    let lastName : Observable<String> = Observable()
    
    /// Phone observable.
    let phone : Observable<String> = Observable()
    
    /// Email observable
    let email : Observable<String> = Observable()
    
    /// Qualification observable
    let qualification : Observable<String> = Observable()
    
    /// Note observable
    let note : Observable<String> = Observable()
    
    /// Reference to view
    weak var view: AddContactViewProtocol?
    
    /// Referemce to router object
    var router : AddEditContactRouterProtocol?
    
    // MARK: - Instance Methods
    
    /// It validates first name of the contact.
    ///
    /// - Returns: Error object in case of failure otherwise nil.
    func validateFirstName() -> (error: Error? , isValidated : Bool)? {
        // First Name.
        guard let firstNameValue = firstName.value else {
            let error = Error(code: 0, description: RealtorLiteral.emptyString, message: "Please enter first name")
            return (error , false)
        }
        if firstNameValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == RealtorLiteral.emptyString {
            let error = Error(code: 0, description: RealtorLiteral.emptyString, message: "Please enter first name")
            return (error , false)
        }
        return nil
    }
    
    /// It validates last name of the contact.
    ///
    /// - Returns: Error object in case of failure otherwise nil.
    func validateLastName() -> (error: Error? , isValidated : Bool)? {
        // Last Name.
        guard let lastNameValue = lastName.value else {
            let error = Error(code: 1, description: RealtorLiteral.emptyString, message: "Please enter last name")
            return (error , false)
        }
        if lastNameValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == RealtorLiteral.emptyString {
            let error = Error(code: 1, description: RealtorLiteral.emptyString, message: "Please enter last name")
            return (error , false)
        }
        return nil
    }
    
    /// It validates phone of the contact.
    ///
    /// - Returns: Error object in case of failure otherwise nil.
    func validatePhone() -> (error: Error? , isValidated : Bool)? {
        // Phone.
        guard let phoneValue = phone.value else {
            let error = Error(code: 2, description: RealtorLiteral.emptyString, message: "Please enter phone number")
            return (error , false)
        }
        if phoneValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == RealtorLiteral.emptyString {
            let error = Error(code: 2, description: RealtorLiteral.emptyString, message: "Please enter phone number")
            return (error , false)
        }
        // Phone validation & verification.
        if  let _trimmedPhoneValue = phone.value?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), _trimmedPhoneValue != RealtorLiteral.emptyString && Utility.isValid(phone: _trimmedPhoneValue) == false {
            let error = Error(code: 2, description: RealtorLiteral.emptyString, message: "Please enter valid phone number")
            return (error , false)
        }
        return nil
    }
    
    /// It validates email address of the contact.
    ///
    /// - Returns: Error object in case of failure otherwise nil.
    func validateEmail() -> (error: Error? , isValidated : Bool)? {
        // Email.
        guard let emailValue = email.value else {
            let error = Error(code: 3, description: RealtorLiteral.emptyString, message: "Please enter email address")
            return (error , false)
        }
        if emailValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == RealtorLiteral.emptyString {
            let error = Error(code: 3, description: RealtorLiteral.emptyString, message: "Please enter email address")
            return (error , false)
        }
        
        
        // Email validation & verification.
        if let _trimmedEmailValue = email.value?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), _trimmedEmailValue != RealtorLiteral.emptyString && Utility.isValid(email: _trimmedEmailValue) == false {
            let error = Error(code: 3, description: RealtorLiteral.emptyString, message: "Please enter valid email address")
            return (error , false)
        }
        return nil
    }
    
    /// It validate and verify mandatory inputs required for the Contact creation.
    ///
    /// - Returns: Tuple object; first argument is optional error object and second argument tells whether or not validation get succeeded.
    func validate() -> (error: Error? , isValidated : Bool) {
        
        if let firstNameValidationError = validateFirstName() {
            return firstNameValidationError
        }
        
        if let lastNameValidationError = validateLastName() {
            return lastNameValidationError
        }
        
        if let phoneValidationError = validatePhone() {
            return phoneValidationError
        }
        
        if let emailValidationError = validateEmail() {
            return emailValidationError
        }
        
        // Qualification
        if let qualificationValue = qualification.value,
            qualificationValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == RealtorLiteral.emptyString {
            qualification.value = nil
        }
        
        // Note
        if let noteValue = note.value,
            noteValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == RealtorLiteral.emptyString {
            note.value = nil
        }
        
        return (nil,true)
    }
    
    // MARK: - ContactPresenterProtocol Method Requirements
    func dismiss() {
        if let _view = view {
            router?.dismiss(view: _view)
        }
    }
    
    func viewDismissed() {
        print("view is about to dismiss")
    }
}


