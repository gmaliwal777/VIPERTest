//
//  ContactRouter.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import UIKit

class AddEditContactRouter : AddEditContactRouterProtocol {
    func dismiss(view: AddContactViewProtocol) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.popViewController(animated: true)
        }
    }
}
