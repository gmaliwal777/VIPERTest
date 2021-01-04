//
//  Bindable.swift
//  GoFigure
//
//  Created by Cybage on 8/29/18.
//  Copyright © 2018 Cybage. All rights reserved.
//

import Foundation
import UIKit

protocol Bindable {
    
    
    associatedtype BinderValueType : Equatable
    
    
    /// It updates UI control with the inline bindable value. Implementation is provided by the UI control it View Model can use this method to update the UI on change in the bindable object.
    ///
    /// - Parameter binderValue: It is expected value which can be presented in the UI Control.
    func update(value binderValue: BinderValueType)
    
    
    /// It tells about the current value, presented by the UI control.
    ///
    /// - Returns: Optional associted value.
    func observingValue() -> BinderValueType?
    
    
    /// It binds the Observer with UI control.
    ///
    /// - Parameter binder: biner object, which is being tied with UI control.
    func bind(_ observer : Observable<BinderValueType>)
    
}
