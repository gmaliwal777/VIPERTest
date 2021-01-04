//
//  MockContactViewController.swift
//  VIPERDemoTests
//
//  Created by Macmini on 10/20/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import UIKit
@testable import VIPERDemo


class MockContactViewController : BaseViewController {
    
    // MARK: - Instance Properties
    
    var presenter: AddContactPresenterProtocol?
    var firstNameTextField : UITextField = UITextField()
    var lastNameTextField : UITextField = UITextField()
    var phoneTextField : UITextField = UITextField()
    var emailTextField : UITextField = UITextField()
    
    /// Once executed configuration block, here generally we setup binding from view to presenter
    lazy var onceConfiguration : () = {
        if let _addContactPresenter = presenter  {
            firstNameTextField.bind(_addContactPresenter.firstName)
            lastNameTextField.bind(_addContactPresenter.lastName)
            emailTextField.bind(_addContactPresenter.email)
            phoneTextField.bind(_addContactPresenter.phone)
        }
    }()
}
