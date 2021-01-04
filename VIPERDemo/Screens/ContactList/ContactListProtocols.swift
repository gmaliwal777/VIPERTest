//
//  ContactListProtocols.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/// This protocol is to be implemented by ContactList-View part to get messages from presenter
protocol ContactListViewProtocol : class , ReadableViewProtocol {
    
    /// Reference to the ContactList presenter
    var presenter : ContactListPresenterProtocol? {get set}
    
    /// Presenter ask view part to insert contacts in the list
    ///
    /// - Parameter indexs: array of indexes
    func insertContacts(atIndexes indexs : [Int])
    
    
    /// Presenter ask view part to update contacts in list for the given indexes
    ///
    /// - Parameter indexs: array of indexes
    func updateContacts(atIndexes indexs : [Int])
    
    
    /// Presenter ask view part to delete contacts from list
    ///
    /// - Parameter indexs: array of indexes
    func deleteContacts(atIndexes indexs : [Int])
}

/// This protocol is to be implemented by ContactList presenter
protocol ContactListPresenterProtocol : class, ReadablePresenterProtocol  {
    
    /// Reference to the ContactList view part, Presenter is recommended to refer it weekly
    var view : ContactListViewProtocol? {get set}
    
    /// Reference to ContactList router unit
    var router : ContactListRouterProtocol? {get set}
    
    /// Reference to ContactList Interactor unit
    var interactor : ContactListInteractorInputProtocol? {get set}
    
    /// View part ask presneter to display "Add Contact" module
    func createNewContact()
    
    /// View part ask presenter to show all the contacts
    func showContacts()
    
    /// It tells about the number of contacts
    ///
    /// - Returns: Number of contacts.
    func numberOfContacts() -> Int
    
    /// It returns a full name after creating it with frist-name and last-name.
    ///
    /// - Parameter index: Index of the contact
    func nameOfContact(atIndex index:Int) -> String
    
    /// It returns contact phone number
    ///
    /// - Parameter index: Index of the contact
    func phoneOfContact(atIndex index:Int) -> String
    
    /// View ask persenter to navigate to 'update-contact' page
    ///
    /// - Parameter index: Index of the contact
    func updateContact(atIndex index: Int)
}

/// This protocol is to be implemented by interactor to get messages from presenter
protocol ContactListInteractorInputProtocol : class  {
    
    /// Reference to the ContactList presenter, Interactor is recommended to refer it weekly
    var presenter : ContactListInteractorOutputProtocol? {get set}
    
    /// Fetch all contacts from database
    func retrieveContacts()
    
    /// It fetch contacts from the database for the given managed object ids
    ///
    /// - Parameter contactsManagedObjecIds: contact managed object ids
    func retrive(contacts contactsManagedObjecIds: [NSManagedObjectID])
}


/// This protocol is to be implemented by presenter to get messages from interactor
protocol ContactListInteractorOutputProtocol : class, InteractorOutputProtocol {
    /// Interactor informs presenter part when all the contacts are fetched from database
    ///
    /// - Parameter contacts: collection of contacts
    func didReceive(contacts : [Contact])
    
    /// Interactor informs presenter part when new cotacts are fetched for the requested managed object ids
    ///
    /// - Parameter newInsertedContacts: collection of contacts
    func didReceive(contactsForRequestedManagedObjectIds : [Contact])
    
    /// Interactor informs presenter part when interactor receives error while fetching list of contacts
    ///
    /// - Parameter error: Error object
    func receivedError(error : Error)
}


/// This protocol is to be implemented by ContactListRouter to get messages from ContactListPresenter
protocol ContactListRouterProtocol : class {
    
    /// It creates "Contact List" module
    ///
    /// - Returns: ContactListViewController
    static func createContactListModule() -> UIViewController
    
    /// It creates "Add Contact" module to be presented
    ///
    /// - Returns: ContactViewController object
    func createAddContactModule() -> ContactViewController?
    
    /// It creates 'update-contact' module
    ///
    /// - Parameter contactManagedObjectID: Managed object id of the updating contact.
    /// - Returns: UIViewController which reprsents contact updation page
    func createEditContactModule(forContact contactManagedObjectID: NSManagedObjectID) -> ContactViewController?
}
