//
//  Constant.swift
//  VIPERDemo
//
//  Created by Macmini on 10/5/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import UIKit

struct Alert
{
    // Alert actions
    static let alert = NSLocalizedString("Alert".uppercased(), comment: "")
    static let ok = NSLocalizedString("Ok".uppercased(), comment: "")
    static let cancel = NSLocalizedString("Cancel".uppercased(), comment: "")
    static let yes = NSLocalizedString("YES".uppercased(), comment: "")
    static let no = NSLocalizedString("NO".uppercased(), comment: "")
    
    static let setting = NSLocalizedString("Settings".uppercased(), comment: "")
    static let message = NSLocalizedString("Message".uppercased(), comment: "")
    
}

struct RealtorColor {
    
    static let textViewPlaceholderColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.2)
    static let textViewinputTextColor = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
}

struct PlaceHolder {
    // Contact
    static let addContactNoteTextViewPlaceHolder = "Add Note"
    static let editContactNoteTextViewPlaceHolder = "Edit Note"
}

struct RealtorNotificationIdentifier {
    static let managedObjectsContextDidChangeNotificationIdentiifer = "managedObjectsUpdatedInContextNotificationIdentiifer"
    static let managedObjectsUpdatedInContextNotificationIdentiifer = "managedObjectsUpdatedInContextNotificationIdentiifer"
    static let newManagedObjectsInsertedInContextNotificationIdentifier = "newManagedObjectsInsertedInContextNotificationIdentifier"
    static let contextDeletedManagedObjectsNotificationIdentifier = "contextDeletedManagedObjectsNotificationIdentifier"
    static let updatedJOBCategoryIdentifier = "updatedJOBCategoryIdentifier"
}
