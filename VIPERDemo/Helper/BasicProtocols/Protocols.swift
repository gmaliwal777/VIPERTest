//
//  Protocols.swift
//  VIPERDemo
//
//  Created by Macmini on 10/5/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import CoreData

// MARK: - ViewProtocols

protocol ViewProtocol {
    
    /// Whether or not a view obstructed either by navigation or any popup
    var isViewObstructed : Bool {get}
    
    // It brings the indicator in front to indicate some processing, and obstruct user for further interaction
    func showIndicator()
    
    // dismisses the indicator to indicate completion of the processing, and allow user to enter in the app
    func hideIndicator()
    
    /// Show the error message
    ///
    /// - Parameter error: Error object
    func showError(error:Error)
    
}

protocol ReadableViewProtocol : ViewProtocol {
    /// Presenter requests view part to start looking for data, mean presenter is ready to serve the required information
    func readData()
    
    /// Presenter informs view part for the MOC updates  (updation, insertion and deltion) that preseter has received from the Interactor part
    ///
    /// - Parameter event: MOCEvent (updation, insertion and deltion) object
    func updatesReceived()
}

protocol WritableViewProtocol : ViewProtocol {
    
    /// Presenter has found the invalid data so requesting view part to take appropriate action on validation failure
    ///
    /// - Parameter error: error object presents failure details
    func validationFailed(withError error: Error)
}

protocol ReadableWritableViewProtocol: ReadableViewProtocol, WritableViewProtocol {
    
}

// MARK: - PresenterProtocol

protocol PresenterProtocol {
    
    /// View ask presenter that view part is going to be dismissed
    func viewDismissed()
}

protocol ReadablePresenterProtocol : PresenterProtocol {
    /// It says whether or not presenter ready to serve the data to view part, every provision should respond if this is set to true, It's implementation is recommended to be private on the conforming type
    var isPresenterReady : Bool {get set}
    
    /// View asks presenter to responds MOC event (updation, insertion and deletion) if there is any.
    ///
    /// - Returns: Optional MOCEvent instance
    func proceedWitMOCUpdates()
}

protocol WritablePresenterProtocol : PresenterProtocol {
    /// View asks presenter to update the details in database or at server. Validation happens as part of its implementation so view part is not requird to call validation part separately
    func updateData()
}

protocol ReadableWritablePreseterProtocol : ReadablePresenterProtocol, WritablePresenterProtocol {
    
}
protocol InteractorOutputProtocol {
    
    /// Interactor informs presenter about edition in some of the MOC associated managed objects
    ///
    /// - Parameter editedManagedObjects: array of the edited managed objects
    func mocUpdated(withEditedManagedObjects editedManagedObjectIds:[NSManagedObjectID])
    
    /// Interactor informs presenter about insertion of same kind of the managed objects in another MOC which are managed by own MOC
    ///
    /// - Parameter insertedManagedObjects: array of the new inserted managed objects
    func mocUpdated(withInsertedManagedObjects insertedManagedObjectIds: [NSManagedObjectID])
    
    
    /// Interactor informs presenter about deletion of the MOC associated managed objects
    ///
    /// - Parameter deletedManagedObjects: array of the deleted managed objects
    func mocUpdated(withDeletedManagedObjects deletedManagedObjectIds:[NSManagedObjectID])
}

// MARK: - InteractorProtocol

