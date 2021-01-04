//
//  BaseWindow.swift
//  VIPERDemo
//
//  Created by Macmini on 10/5/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import UIKit

class BaseWindow: UIWindow {
    
    // MARK: - Instance Properties
    
    /// It keeps increasing with the call to showIndicator() method, and decreasing with the call to hideIndicator(). Indictor does not gets hidden until retainCount becomes 0.
    var retainCount = 0
    
    /// It is indicator view, which will appears on top of window.
    let loaderView = LoaderView(frame: CGRect.zero)
    
    //// MARK: - Instance Methods
    
    /// Show the indicator view, and make user unable to interact.
    func showIndicator() {
        
        retainCount += 1
        guard loaderView.superview != nil else {
            if let keyView = rootViewController?.view {
                loaderView.show(inView: keyView)
                bringSubviewToFront(loaderView)
                return
            }
            return
        }
    }
    
    /// Hide the indicator view, and make user able to interact with the system.
    func hideIndicator() {
        
        retainCount -= 1
        if retainCount <= 0 {
            loaderView.hide()
            sendSubviewToBack(loaderView)
            retainCount = 0
        }
    }
}
