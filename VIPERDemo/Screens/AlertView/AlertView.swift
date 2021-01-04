//
//  AlertView.swift
//  VIPERDemo
//
//  Created by Macmini on 10/5/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import UIKit

typealias CallbackType = () -> Void

/// Type to present alert context
struct AlertContext {
    
    let title : String?
    let message : String
    let actions : [CallbackType]
    let titles : [String]
    let actionStyle : UIAlertController.Style
}

class AlertView: NSObject , UIAlertViewDelegate {
    
    // MARK: - Properties
    
    // stack of Alert Event actions
    var actions : [CallbackType]?
    
    // Stack of AlertContext
    var alertStack = [AlertContext]()
    
    // SharedInstance of AlertView
    static let sharedInstance = AlertView()
    
    // MARK: - Super Class Methods
    private override init() {}
    
    // MARK: - Instance methods
    
    /// Show netowrk unavailable message and redirect to network setting page
    func showNetworkUnAvailableMessage() {
        let okHandler = {() -> Void in}
        showAlertView(title: "Network Failure", message: "Please Check Your Network Connection", actions: [okHandler], titles: ["Ok"], actionStyle: UIAlertController.Style.alert)
    }
    
    /// Display message, it is managed in stack to be displayed later if there is another message being displayed
    ///
    /// - Parameters:
    ///   - title: Alert message title
    ///   - message: Alert message
    ///   - actions: array of actions
    ///   - titles: titles of actions
    ///   - actionStyle: Alert action style
    func showAlertView(title : String? , message : String , actions : [CallbackType] , titles: [String] , actionStyle : UIAlertController.Style) {
        
        if self.actions != nil {
            //AlertView is already on UI part, add this alert into stack
            
            alertStack.append(AlertContext(title: title, message: message, actions: actions, titles: titles,actionStyle : actionStyle))
            return
        }
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: actionStyle)
        alertController.view.tintColor = UIColor(red: 47/255, green: 81/255, blue: 163/255, alpha: 1)
        
        self.actions = actions
        
        for counter in 0  ..< actions.count {
            
            if let handler : CallbackType = self.actions?[counter] {
                
                let actionHandler = {[weak self] (action : UIAlertAction) -> Void in
                    
                    handler()
                    
                    self?.actions = nil
                    
                    if let alertContext = self?.alertStack.first {
                        // Showing other alert's if exist in the stack.
                        if let alertStackCount = self?.alertStack.count, alertStackCount > 0 {
                            let alertContext : AlertContext = alertContext
                            
                            self?.showAlertView(title: alertContext.title, message: alertContext.message, actions: alertContext.actions, titles: alertContext.titles,actionStyle:alertContext.actionStyle)
                            
                            self?.alertStack.removeFirst()
                        }
                    }
                }
                let alertAction = UIAlertAction(title: titles[counter], style: .default, handler: actionHandler)
                
                alertController.addAction(alertAction)
            }
        }
        
        if actionStyle == UIAlertController.Style.actionSheet {
            let cancelHandler = {[weak self] (action : UIAlertAction) -> Void in
                
                self?.actions = nil
                if let alertContext = self?.alertStack.first {
                    if let alertStackCount = self?.alertStack.count, alertStackCount > 0 {
                        let alertContext : AlertContext = alertContext
                        
                        self?.showAlertView(title: alertContext.title, message: alertContext.message, actions: alertContext.actions, titles: alertContext.titles, actionStyle: alertContext.actionStyle)
                        
                        self?.alertStack.removeFirst()
                    }
                }
            }
            
            let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler)
            alertController.addAction(alertCancelAction)
        }
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            if let rootAsTabController = rootController as? UITabBarController, let selectedTabController = rootAsTabController.selectedViewController {
                if let presentedController = selectedTabController.presentedViewController {
                    presentedController.present(alertController, animated: true, completion: nil)
                } else {
                    selectedTabController.present(alertController, animated: true, completion: nil)
                }
            } else {
                if let presentedController = rootController.presentedViewController {
                    presentedController.present(alertController, animated: true, completion: nil)
                } else {
                    rootController.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

