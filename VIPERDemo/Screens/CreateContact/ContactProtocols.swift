//
//  ContactProtocols.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import CoreData
import UIKit


/// This protocol is to be implemented by the view part for getting messages from presenter
protocol AddContactViewProtocol : class , ReadableWritableViewProtocol {
    
    // MARK: - Property Requirements
    
    /// Reference to presenter to create a contact
    var presenter: ContactPresenterProtocol? { get set }
    
    // MARK: - Method Requirements
    
    /// Presenter informs view part when a contact is successfully created
    ///
    /// - Parameter managedObjectID: Managed Object ID of the created contact
    func created(contact managedObjectID : NSManagedObjectID)
}


/// Common contact presenter interface for the Add/Edit presenter
protocol ContactPresenterProtocol : class, WritablePresenterProtocol {
    // MARK: - Property Requirements
    
    /// Reference to view, presener is recommended to refer it weekly
    var view : AddContactViewProtocol? {get set}
    
    /// Reference to router
    var router : AddEditContactRouterProtocol? {get set}
    
    /// FirstName observable object
    var firstName : Observable<String> {get}
    
    /// Last Name observalbe object
    var lastName : Observable<String> {get}
    
    /// Phone observable object
    var phone : Observable<String> {get}
    
    /// Email observable object
    var email : Observable<String> {get}
    
    /// Qualification observable object
    var qualification : Observable<String> {get}
    
    /// Note observable object
    var note : Observable<String> {get}
    
    /// Title of the button
    var buttonTitle : String {get}
    
    /// Placeholder for first name text-field
    var firstNameTextFieldPlaceholder : String {get}
    
    /// Placeholder for last name text-field
    var lastNameTextFieldPlaceholder : String {get}
    
    /// Placeholder for phone text-field
    var phoneTextFieldPlaceholder : String {get}
    
    /// Placeholder for email text-field
    var emailTextFieldPlaceholder : String {get}
    
    /// Name of the screen
    var screenTitle : String {get}
    
    // MARK: - Method Requirements
    
    /// Dismiss the view either to cancel the contact creation or close the context on contact creation
    func dismiss()
}

/// This protocol is to be implemented by add contact presenter module for getting messages from view part
protocol AddContactPresenterProtocol : ContactPresenterProtocol  {
    // MARK: - Property Requirements
    
    /// Reference to interactor to create contact in the database
    var interactor : AddContactInteractorInputProtocol? {get set}
    
}

protocol EditContactPresenterProtocol : ContactPresenterProtocol, ReadablePresenterProtocol {
    // MARK: - Property requirements
    
    /// Reference to core-data managed object id which represents contact
    var contactManagedObjectID : NSManagedObjectID {get set}
    
    /// Reference to interactor to create contact in the database
    var interactor : EditContactInteractorInputProtocol? {get set}
    
    // MARK: - Method Requirements
    
    /// View part ask presenter to fetch contact profile from database
    func showContactProfile()
    
    /// First name of the contact
    ///
    /// - Returns: First name
    func getFirstName() -> String?
    
    /// Last name of the contact
    ///
    /// - Returns: Last name
    func getLastName() -> String?
    
    /// Phone of the contact
    ///
    /// - Returns: Phone number
    func getPhone() -> String?
    
    /// Email of the contact
    ///
    /// - Returns: Email
    func getEmail() -> String?
    
    /// Qualification of the contact
    ///
    /// - Returns: Qualification
    func getQualification() -> String?
    
    /// Note of the contact
    ///
    /// - Returns: Note
    func getNote() -> String?
}

/// This protocol is to be implemented by interactor to get messages from presenter
protocol AddContactInteractorInputProtocol : class  {
    
    // MARK: - Property Requirements
    
    /// Reference to the AddContact module presenter, Interactor is recommended to refer it weekly
    var presenter : AddContactInteractorOutputProtocol? {get set}
    
    // MARK: - Method Requirements
    
    /// Creates and store a new contact in the database
    ///
    /// - Parameter dataModel: Contact data model
    func create(contact dataModel :ContactModel)
}

/// This protocol is to be implemented by edit-contact interactor to get messages from presenter
protocol EditContactInteractorInputProtocol : class  {
    
    // MARK: - Property Requirements
    
    /// Reference to the presenter of EditContact module, Interactor is recommended to refer it weekly
    var presenter : EditContactInteractorOutputProtocol? {get set}
    
    // MARK: - Method Requirements
    
    /// Fetch contact profile from database asynchronously
    ///
    /// - Parameter contactManagedObjectID: Managed object id of the contact
    func fetch(contact contactManagedObjectID: NSManagedObjectID)
}


/// This protocol is to be implemented by presenter to get messages from interactor
protocol AddContactInteractorOutputProtocol : class {
    // MARK: - Property Requirements
    
    /// Interactor informs presenter part when a contact is successfully created
    ///
    /// - Parameter managedObjectID: Managed Object ID of the created contact
    func created(contact managedObjectID : NSManagedObjectID)
    
    // MARK: - Method Requirements
    
    /// Interactor informs presenter part when a contact creation gets failed
    func contactNotCreated()
}

/// This protocol is to be implemented by edit-contact presenter to get messages from interactor
protocol EditContactInteractorOutputProtocol : class {
    /// Interactor informs presenter part when a contact is fetched from database
    ///
    /// - Parameter contacts: a contact object
    func didReceive(contact : Contact)
    
    /// Interactor informs presenter part when interactor receives error while fetching a contact profile
    ///
    /// - Parameter error: Error object
    func receivedError(error : Error)
}

protocol AddEditContactRouterProtocol {
    // MARK: - Method Requirements
    
    /// Dismiss the controller
    ///
    /// - Parameter view: View-controller
    func dismiss(view:AddContactViewProtocol)
}





