//
//  BaseViewController.swift
//  GoFigure
//
//  Created by Cybage on 9/7/18.
//  Copyright © 2018 Cybage. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, ViewProtocol {
    
    var isViewObstructed: Bool {
        return false
    }
    
    // MARK: - IBOutlet property
    @IBOutlet weak var scrollView : UIScrollView?
    
    // MARK: - Instance Properties
    
    /// It refers to active user input, default it is set to nil.
    var activeInput : UIView?
    
    /// It is the visible scrollable area, and it gets changed with keyboard appearance and disappearance.
    fileprivate var visibleScrollableArea : CGRect?
    
    // MARK: - UIViewController Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShowEventHandler(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideEventHandler(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        isViewNavigationObstructed = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ViewProtocol Requirements
    
    /// It says whether view part is obstructed with popup. Derived class can MARK this flag true/false whenever required.
    var isViewPopupObstructed = false
    
    /// It says whether view part is obstructed with navigation stack. Derived class can MARK this flag true/false whenever required.
    var isViewNavigationObstructed = false
    
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
    
    // MARK: - Instance Methods
    
    /// It brings child view of scroll-view in visibility,
    ///
    /// - Parameter view: It is child-view of scroll-view
    func bringViewInFocus(view : UIView) {
        let focusedArea = view.frame
        if let _visibleScrollabelArea = visibleScrollableArea{
            if _visibleScrollabelArea.contains(focusedArea) == false {
                scrollView?.scrollRectToVisible(focusedArea, animated: true)
            }
        }
    }
    
    /// It responds to UIKeyboardDidShow event. It is considered that scrollview consists
    ///
    /// - Parameter notification: UIKeyboardDidShow notification object
    @objc func keyboardDidShowEventHandler(notification : Notification) {
        
        if let _scrollView = scrollView, let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let scrollViewRectFromContainerView = _scrollView.convert(_scrollView.bounds, to: view)
            let scrollViewContentHeight = scrollViewRectFromContainerView.size.height
            let topSpaceToScrollView = scrollViewRectFromContainerView.origin.y
            let bottomSpaceToScrollView = UIScreen.main.bounds.size.height - topSpaceToScrollView - scrollViewContentHeight
            
            let bottomInsetValue = keyboardSize.size.height - bottomSpaceToScrollView
            
            _scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom:bottomInsetValue   , right: 0.0)
            visibleScrollableArea = CGRect(x: 0.0, y: 0.0, width: scrollViewRectFromContainerView.size.width, height: scrollViewRectFromContainerView.size.height - bottomInsetValue)
            if let _activeUserInput = activeInput {
                bringViewInFocus(view: _activeUserInput)
            }
        }
    }
    
    
    /// It responds to UIKeyboardWillHide event.
    ///
    /// - Parameter notification: UIKeyboardWillHide notification object.
    @objc func keyboardWillHideEventHandler(notification : Notification) {
        scrollView?.contentInset = UIEdgeInsets.zero
        visibleScrollableArea = nil
    }
    

    // MARK: - IBAction Methods
    @IBAction func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    /// It handle user tap action on view.
    @IBAction func handleTapEvent() {
        view.endEditing(true)
    }
    
    
}

