//
//  ContactModelTests.swift
//  VIPERDemoTests
//
//  Created by Macmini on 10/21/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import XCTest
@testable import VIPERDemo

class ContactModelTests: XCTestCase {

    // MARK: - Test Methods
    
    /// It checks integrity of the contact data model.
    func testModel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let contactDataModel = ContactModel(firstName: "Ghanshyam", lastName: "Maliwal", phone: "9414440765", email: "gmaliwal777@gmail.com", qualification: "MCA", note: "Note for Ghanshyam")
        XCTAssert(contactDataModel.firstName == "Ghanshyam", "ContactModel: System is not remembering expected value for first name")
        XCTAssert(contactDataModel.lastName == "Maliwal", "ContactModel: System is not remembering expected value for last name")
        XCTAssert(contactDataModel.phone == "9414440765", "ContactModel: System is not remembering expected value for phone")
        XCTAssert(contactDataModel.email == "gmaliwal777@gmail.com", "ContactModel: System is not remembering expected value for email")
        XCTAssert(contactDataModel.qualification == "MCA", "ContactModel: System is not remembering expected value for qualification")
        XCTAssert(contactDataModel.note == "Note for Ghanshyam", "ContactModel: System is not remembering expected value for note")
    }

}
