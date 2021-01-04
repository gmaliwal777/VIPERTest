//
//  ContactViewControllerTests.swift
//  VIPERDemoTests
//
//  Created by Macmini on 10/20/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import XCTest
@testable import VIPERDemo

class ContactViewControllerTests: XCTestCase {

    // MARK: - Instance properties
    /// Reference to instance of ContactViewController type
    var contactViewController : ContactViewController!
    
    // MARK: - XCTest Life Cycle Methods
    override func setUp() {
        contactViewController = ContactViewController(nibName: nil, bundle: nil)
        super.setUp()
    }

    override func tearDown() {
        contactViewController = nil
    }

    // MARK: - Test Methods
    
    /// It checks whether it conforms to text-field delegate or not
    func testForTextFieldDelegateConformance() {
        if (contactViewController as? UITextFieldDelegate) == nil {
            XCTAssertTrue(false, "ContactViewController is expected to conform UITextFieldDelegate")
        }
    }

    /// It checks whether it conforms to text-view delegate or not
    func testForTextViewDelegateConformance() {
        if (contactViewController as? UITextViewDelegate) == nil {
            XCTAssertTrue(false, "ContactViewController is expected to conform UITextViewDelegate")
        }
    }
    
    /// It checks whether it conforms to AddContactViewProtocol or not
    func testForAddContactViewProtocolConformance() {
        if (contactViewController as? AddContactViewProtocol) == nil {
            XCTAssertTrue(false, "ContactViewController is expected to conform AddContactViewProtocol")
        }
    }
    
    
}
