//
//  AddContactPresenterTests.swift
//  VIPERDemoTests
//
//  Created by Macmini on 10/20/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import XCTest
@testable import VIPERDemo

class AddContactPresenterTests: XCTestCase {
    
    // MARK: - Instance properties
    
    /// Reference to instance of ContactViewController type
    var contactViewController : MockContactViewController!
    
    /// Reference to instance of AddContactPresenter
    var addContactPresenter : AddContactPresenter!
    
    // MARK: - XCTest Life Cycle Methods
    
    override func setUp() {
        addContactPresenter = AddContactPresenter()
        
        contactViewController = MockContactViewController()
        contactViewController.presenter = addContactPresenter
        let _ = contactViewController.onceConfiguration
        
        super.setUp()
    }

    override func tearDown() {
        contactViewController = nil
        addContactPresenter = nil
        super.tearDown()
    }

    // MARK: - Test Methods
    
    // MARK: - First Name Validation
    
    /// It checks whether blank first name is validated or not, and checks alert message in case of failure
    func testBlankFirstName() {
        contactViewController.firstNameTextField.text = ""
        contactViewController.firstNameTextField.valueChanged()
        guard let validation = addContactPresenter.validateFirstName() else {
            XCTAssert(false, "Add Contact: First name can not be blank")
            return
        }
        XCTAssert(validation.error?.message.uppercased() == "Please enter first name".uppercased(), "Add Contact: Wrong alert message for blank first name test case")
    }
    
    /// It checks whether first name with white-spaces gets validated or not, and checks alert message in case of failure
    func testFirstNameWithAllWhiteSpaces() {
        contactViewController.firstNameTextField.text = "     "
        contactViewController.firstNameTextField.valueChanged()
        guard let validation = addContactPresenter.validateFirstName() else {
            XCTAssertTrue(false, "Add Contact: First name must not have white spaces")
            return
        }
        XCTAssert(validation.error?.message.uppercased() == "Please enter first name".uppercased(), "Add Contact: Wrong alert message for first name with all whitespac characters")
    }
    
    /// It checks whether a decent first name gets validated or not
    func testDecentFirstName() {
        contactViewController.firstNameTextField.text = "Ghanshyam"
        contactViewController.firstNameTextField.valueChanged()
        XCTAssertTrue(addContactPresenter.validateFirstName() == nil, "Add Contact: This is decent first name, expected to pass through the validation")
    }
    
    // MARK: - Last Name Validation
    
    /// It checks whether blank last name is validated or not, and verify alert message in case of failure
    func testBlankLastName() {
        contactViewController.lastNameTextField.text = ""
        contactViewController.lastNameTextField.valueChanged()
        guard let validation = addContactPresenter.validateLastName() else {
            XCTAssertTrue(false, "Add Contact: Last name must not be blank")
            return
        }
        XCTAssert(validation.error?.message.uppercased() == "Please enter last name".uppercased(), "Add Contact: Wrong alert message for blank last name test case")
    }
    
    /// It checks whether last name with white-spaces gets validated or not, and verify alert message in case of failure
    func testLastNameWithAllWhiteSpaces() {
        contactViewController.lastNameTextField.text = "     "
        contactViewController.lastNameTextField.valueChanged()
        guard let validation = addContactPresenter.validateLastName() else {
            XCTAssertTrue(false, "Add Contact: Last name must not have white spaces")
            return
        }
        XCTAssert(validation.error?.message.uppercased() == "Please enter last name".uppercased(), "Add Contact: Wrong alert message for last name with all whitespac characters")
    }
    
    /// It checks whether a decent last name gets validated or not
    func testDecentLastName() {
        contactViewController.lastNameTextField.text = "Maliwal"
        contactViewController.lastNameTextField.valueChanged()
        XCTAssert(addContactPresenter.validateLastName() == nil, "Add Contact: This is decent last name, expected to pass through the validation")
    }
    
    // MARK: - Phone Number Validation
    
    /// It checks whether blank phone number gets validated or not, and verify alert message in case of failure
    func testBlankPhoneNumber() {
        contactViewController.phoneTextField.text = ""
        contactViewController.phoneTextField.valueChanged()
        guard let validation = addContactPresenter.validatePhone() else {
            XCTAssertTrue(false, "Add Contact: Blank phone number is not allowed")
            return
        }
        XCTAssert(validation.error?.message.uppercased() == "Please enter phone number".uppercased(), "Add Contact: Wrong alert message for blank phone number")
    }
    
    /// It checks whether phone number (having all whitespaces) gets validated or not, and verify alert message in case of failure
    func testPhoneNumberWithWhiteSpaces() {
        contactViewController.phoneTextField.text = "   "
        contactViewController.phoneTextField.valueChanged()
        guard let validation = addContactPresenter.validatePhone() else {
            XCTAssertTrue(false, "Add Contact: phone number with all whitespace characters is not allowed")
            return
        }
        XCTAssert(validation.error?.message.uppercased() == "Please enter phone number".uppercased(), "Add Contact: Wrong alert message for phone number with all whitespac characters")
    }
    
    /// It checks whether phone number (having less than 10 digits) gets validated or not, and verify alert message in case of failure
    func testInvalidPhoneNumber() {
        contactViewController.phoneTextField.text = "   784585  "
        contactViewController.phoneTextField.valueChanged()
        guard let validation = addContactPresenter.validatePhone() else {
            XCTAssertTrue(false, "Add Contact: phone number with less than 10 digits is not allowed")
            return
        }
        XCTAssert(validation.error?.message.uppercased() == "Please enter valid phone number".uppercased(), "Add Contact: Wrong alert message for phone number with less than 10 digits")
    }
    
    /// It checks whether a decent phone number gets validated or not
    func testDecentPhoneNumber() {
        contactViewController.phoneTextField.text = "9423931947"
        contactViewController.phoneTextField.valueChanged()
        XCTAssert(addContactPresenter.validatePhone() == nil, "Add Contact: This is decent phone number, expected to pass through the validation")
    }
    
    // MARK: - Email Verification
    
    /// It checks whether blank email-address gets validated or not, and verify alert message in case of failure
    func testBlankEmailAddress() {
        contactViewController.emailTextField.text = ""
        contactViewController.emailTextField.valueChanged()
        guard let validation = addContactPresenter.validateEmail() else {
            XCTAssertTrue(false, "Add Contact: Blank email is not allowed")
            return
        }
        XCTAssert(validation.error?.message.uppercased() == "Please enter email address".uppercased(), "Add Contact: Wrong alert message for blank email address")
    }
    
    /// It checks whether email-address (having all whitespaces) gets validated or not, and verify alert message in case of failure
    func testEmailWithWhiteSpaces() {
        contactViewController.emailTextField.text = "   "
        contactViewController.emailTextField.valueChanged()
        guard let validation = addContactPresenter.validateEmail() else {
            XCTAssertTrue(false, "Add Contact: Email with all whitespace characters is not allowed")
            return
        }
        XCTAssert(validation.error?.message.uppercased() == "Please enter email address".uppercased(), "Add Contact: Wrong alert message for email with all whitespac characters")
    }
    
    /// It checks whether bad formatted email gets validated or not, and verify alert message in case of failure
    func testInvalidEmailAddress() {
        contactViewController.emailTextField.text = "   abc@@gm.in  "
        contactViewController.emailTextField.valueChanged()
        guard let validation = addContactPresenter.validateEmail() else {
            XCTAssertTrue(false, "Add Contact: bad formatted email is not allowed")
            return
        }
        XCTAssert(validation.error?.message.uppercased() == "Please enter valid email address".uppercased(), "Add Contact: Wrong alert message for bad formatted email")
    }
    
    /// It checks whether a decent email address gets validated or not
    func testDecentEmailAddress() {
        contactViewController.emailTextField.text = "abc@gmail.com"
        contactViewController.emailTextField.valueChanged()
        XCTAssert(addContactPresenter.validateEmail() == nil, "Add Contact: This is decent email address, expected to pass through the validation")
    }
    
    
    /// It test out all the fields required for contact creation
    func testAddContactInputFields() {
        contactViewController.firstNameTextField.text = "Ghanshyam"
        contactViewController.firstNameTextField.valueChanged()
        
        contactViewController.lastNameTextField.text = "Maliwal"
        contactViewController.lastNameTextField.valueChanged()
        
        contactViewController.phoneTextField.text = "9423931947"
        contactViewController.phoneTextField.valueChanged()
        
        contactViewController.emailTextField.text = "abc@gmail.com"
        contactViewController.emailTextField.valueChanged()
        
        let validation = addContactPresenter.validate()
        XCTAssert(validation.error == nil, "Add Contact: All inputs are decent, and expected to pass through the validation")
    }
    
    /// It checks whether presenter implements AddContactPresenterProtocol type or not
    func testForAddContactPresenterProtocolConformance() {
        XCTAssertTrue((addContactPresenter as? AddContactPresenterProtocol) != nil, "AddContactPresenter is expected to conform AddContactPresenterProtocol type")
    }
    
    /// It checks whether presenter implements AddContactInteractorOutputProtocol type or not
    func testForAddContactInteractorOutputProtocolConformance() {
        XCTAssertTrue((addContactPresenter as? AddContactInteractorOutputProtocol) != nil, "AddContactPresenter is expected to conform AddContactInteractorOutputProtocol type")
    }
}
