//
//  BaseView.swift
//  VIPERDemo
//
//  Created by Macmini on 10/5/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    //// MARK: - Instance properties
    
    /// It says whether view part is "popup/navigation statck" obstructed. Derived class can MARK this flag true/false whenever required.
    var isViewObstructed = false
}

// MARK: - ViewProtocol

extension BaseView : ViewProtocol {
    
    func showIndicator() {
        //Showing indicator.
        if let baseWindow = UIApplication.shared.keyWindow as? BaseWindow {
            baseWindow.showIndicator()
        }
    }
    
    func hideIndicator() {
        if let baseWindow = UIApplication.shared.keyWindow as? BaseWindow {
            baseWindow.hideIndicator()
        }
    }
    
    func showError(error: Error) {
        let okHandler = {}
        AlertView.sharedInstance.showAlertView(title: Alert.message, message: error.message, actions: [okHandler], titles: [Alert.ok], actionStyle: UIAlertController.Style.alert)
    }
}
