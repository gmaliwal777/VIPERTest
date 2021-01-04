//
//  ContactListRouter.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ContactListRouter : ContactListRouterProtocol {
    
    // MARK: - ContactListRouterProtocol
    
    /// It creates contact list context.
    ///
    /// - Returns: UIViewController which reprsents list of contacts
    static func createContactListModule() -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "ContactListNavViewController")
        if let contactListViewController = navController.children.first as? ContactListViewController {
            
            let presenter : ContactListPresenterProtocol & ContactListInteractorOutputProtocol = ContactListPresenter()
            let router : ContactListRouterProtocol = ContactListRouter()
            let interactor : ContactListInteractorInputProtocol = ContactListInteractor()
            
            contactListViewController.presenter = presenter
            interactor.presenter = presenter
            
            presenter.view = contactListViewController
            presenter.router = router
            presenter.interactor = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    
    /// It creates 'add-contact' module
    ///
    /// - Returns: UIViewController which reprsents contact creation page
    func createAddContactModule() -> ContactViewController? {
        print("create add contact module")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let contactViewController = mainStoryboard.instantiateViewController(withIdentifier: "ContactViewController") as? ContactViewController else {
            return nil
        }
        
        let presenter : AddContactPresenterProtocol & AddContactInteractorOutputProtocol = AddContactPresenter()
        let interactor : AddContactInteractorInputProtocol = AddContactInteractor()
        let router : AddEditContactRouterProtocol = AddEditContactRouter()
        
        contactViewController.presenter = presenter
        presenter.view = contactViewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return contactViewController
    }
    
    
    /// It creates 'update-contact' module
    ///
    /// - Parameter contactManagedObjectID: Managed object id of the updating contact.
    /// - Returns: UIViewController which reprsents contact updation page
    func createEditContactModule(forContact contactManagedObjectID: NSManagedObjectID) -> ContactViewController? {
        print("create add contact module")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let contactViewController = mainStoryboard.instantiateViewController(withIdentifier: "ContactViewController") as? ContactViewController else {
            return nil
        }
        
        let presenter : EditContactPresenterProtocol & EditContactInteractorOutputProtocol = EditContactPresenter(contact: contactManagedObjectID)
        let interactor : EditContactInteractorInputProtocol = EditContactInteractor()
        let router : AddEditContactRouterProtocol = AddEditContactRouter()
        
        contactViewController.presenter = presenter
        presenter.view = contactViewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return contactViewController
    }
    
}
