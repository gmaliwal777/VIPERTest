//
//  ContactViewController.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ContactViewController : BaseViewController {
    
    // MARK: - IBOutlet's
    
    @IBOutlet private weak var firstNameTextField : UITextField!
    @IBOutlet private weak var lastNameTextField : UITextField!
    @IBOutlet private weak var phoneTextField : UITextField!
    @IBOutlet private weak var emailTextField : UITextField!
    @IBOutlet private weak var qualificationTextField : UITextField!
    @IBOutlet private weak var noteTextView : UITextView!
    @IBOutlet private weak var actionButton : UIButton!
    
    // MARK: - Instance Properties
    
    var presenter: ContactPresenterProtocol?
    
    /// Once executed configuration block, here generally we setup binding from view to presenter
    lazy var onceConfiguration : () = {
        noteTextView.text = PlaceHolder.addContactNoteTextViewPlaceHolder
        noteTextView.textColor = RealtorColor.textViewPlaceholderColor
        
        if let _addContactPresenter = presenter  {
            firstNameTextField.bind(_addContactPresenter.firstName)
            firstNameTextField.bind(_addContactPresenter.firstName)
            lastNameTextField.bind(_addContactPresenter.lastName)
            emailTextField.bind(_addContactPresenter.email)
            phoneTextField.bind(_addContactPresenter.phone)
            qualificationTextField.bind(_addContactPresenter.qualification)
            noteTextView.bind(_addContactPresenter.note)
        }
        
        actionButton.setTitle(presenter?.buttonTitle, for: .normal)
        firstNameTextField.placeholder = presenter?.firstNameTextFieldPlaceholder
        lastNameTextField.placeholder = presenter?.lastNameTextFieldPlaceholder
        phoneTextField.placeholder = presenter?.phoneTextFieldPlaceholder
        emailTextField.placeholder = presenter?.emailTextFieldPlaceholder
        self.title = presenter?.screenTitle
    }()
    
    // MARK: - UIViewController LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = onceConfiguration
        (presenter as? EditContactPresenterProtocol)?.showContactProfile()
    }
    
    // MARK: - IBAction Methods
    @IBAction func addContact() {
        presenter?.updateData()
    }
    
    // MARK: - Instance Methods
    
    /// Responds by bringing input fields in focus to enter valid details
    ///
    /// - Parameter error: Error object
    func respond(toValidationError error: Error) {
        if error.code == 0 {
            //First Name
            firstNameTextField.becomeFirstResponder()
        } else if error.code == 1 {
            // Last Name
            lastNameTextField.becomeFirstResponder()
        } else if error.code == 2 {
            // Phone
            phoneTextField.becomeFirstResponder()
        } else if error.code == 3 {
            // Email
            emailTextField.becomeFirstResponder()
        }
    }
}

// MARK: - UITextFieldDelegate
extension ContactViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textFieldSuperview = textField.superview {
            activeInput = textField.superview
            bringViewInFocus(view: textFieldSuperview)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeInput = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            phoneTextField.becomeFirstResponder()
        } else if textField == phoneTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            qualificationTextField.becomeFirstResponder()
        } else if textField == qualificationTextField {
            noteTextView.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            activeInput = nil
        }
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextField {
            let newLength: Int = textField.text!.count + string.count - range.length
            let numberOnly = NSCharacterSet.init(charactersIn: PhoneAndZipConstants.acceptableNumbers).inverted
            let validString = string.rangeOfCharacter(from: numberOnly) == nil
            return (validString && (newLength <= PhoneAndZipConstants.maximumLengthOfPhoneNumber))
        }
        return true
    }
}

// MARK: - UITextViewDelegate

extension ContactViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let textViewSuperView = textView.superview {
            activeInput = textViewSuperView
            bringViewInFocus(view: textViewSuperView)
        }
        
        if textView.textColor == RealtorColor.textViewPlaceholderColor {
            textView.text = nil
            textView.textColor = RealtorColor.textViewinputTextColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        activeInput = nil
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = PlaceHolder.addContactNoteTextViewPlaceHolder
            textView.textColor = RealtorColor.textViewPlaceholderColor
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.valueChanged()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

// MARK: - AddContactViewProtocol
extension ContactViewController : AddContactViewProtocol {
    
    func readData() {
        print("read contact profile")
        if let editContactPresenter = presenter as? EditContactPresenterProtocol {
            firstNameTextField.text = editContactPresenter.getFirstName()
            lastNameTextField.text = editContactPresenter.getLastName()
            phoneTextField.text = editContactPresenter.getPhone()
            emailTextField.text = editContactPresenter.getEmail()
            qualificationTextField.text = editContactPresenter.getQualification()
            noteTextView.text = editContactPresenter.getNote()
        }
        
    }
    
    func updatesReceived() {
        print("received updates")
    }
    
    func validationFailed(withError error: Error) {
        print("handle validation error")
        
        let okHandler = { [weak self] () -> Void in
            self?.respond(toValidationError: error)
        }
        AlertView.sharedInstance.showAlertView(title: Alert.message , message: error.message, actions: [okHandler], titles: [Alert.ok ], actionStyle: UIAlertController.Style.alert)
    }
    
    func created(contact managedObjectID: NSManagedObjectID) {
        print("contact is created successfully")
        presenter?.dismiss()
    }
}


