//
//  MVVMExtensions.swift
//  GoFigure
//
//  Created by Cybage on 8/29/18.
//  Copyright © 2018 Cybage. All rights reserved.
//

import Foundation
import UIKit


private struct AssociatedKeys {
    static var binder : Int8 = 0
}

//// MARK: - Bindable
extension UITextField : Bindable {
    
    //// MARK: - Custom type/ Properties
    
    /// Binder value type is string.
    typealias BinderValueType = String
    
    /// It is computed property, it associate bindable object with UI control.
    var binder: Observable<BinderValueType> {
        get {
            guard let observer = objc_getAssociatedObject(self, &AssociatedKeys.binder) as? Observable<BinderValueType> else {
                let observer = Observable<BinderValueType>()
                objc_setAssociatedObject(self, &AssociatedKeys.binder, observer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return observer
            }
            return observer
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.binder, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //// MARK: - Bindable methods
    
    func update(value binderValue: String) {
        text = binderValue
    }
    
    func observingValue() -> String? {
        return text
    }
    
    func bind(_ observer: Observable<String>) {
        addTarget(self, action: #selector(valueChanged), for: [.editingChanged,.valueChanged])
        binder = observer
    }
    
    // MARK: - Instance Methods
    
    
    /// It is called on value change.
    @objc func valueChanged() {
        if binder.value != observingValue() {
            setBinder(withValue: observingValue())
        }
    }
    
    /// It set binder value.
    ///
    /// - Parameter explicitValue: value to be set into binder value property.
    func setBinder(withValue explicitValue : BinderValueType?) {
        binder.value = explicitValue
    }
    
    
    /// It return value associated with binder.
    ///
    /// - Returns: Optional binder value.
    func getBinderValue() -> BinderValueType? {
        return binder.value
    }
}




//// MARK: - Bindable
extension UITextView : Bindable {
    
    //// MARK: - Custom type/ Properties
    
    /// Binder value type is string.
    typealias BinderValueType = String
    
    /// It is computed property, it associate bindable object with UI control.
    var binder: Observable<BinderValueType> {
        get {
            guard let observer = objc_getAssociatedObject(self, &AssociatedKeys.binder) as? Observable<BinderValueType> else {
                let observer = Observable<BinderValueType>()
                objc_setAssociatedObject(self, &AssociatedKeys.binder, observer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return observer
            }
            return observer
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.binder, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //// MARK: - Bindable methods
    
    func update(value binderValue: String) {
        text = binderValue
    }
    
    func observingValue() -> String? {
        return text
    }
    
    func bind(_ observer: Observable<String>) {
        binder = observer
    }
    
    // MARK: - Instance Methods
    
    
    /// It is called on value change.
    @objc func valueChanged() {
        
        if binder.value != observingValue() {
            setBinder(withValue: observingValue())
        }
    }
    
    /// It set binder value.
    ///
    /// - Parameter explicitValue: value to be set into binder value property.
    func setBinder(withValue explicitValue : BinderValueType?) {
        binder.value = explicitValue
    }
    
    
    /// It return value associated with binder.
    ///
    /// - Returns: Optional binder value.
    func getBinderValue() -> BinderValueType? {
        return binder.value
    }
    
    
}


//// MARK: - Bindable
extension UISlider : Bindable {
    
    
    //// MARK: - Custom type/ Properties
    
    /// Binder value type is string.
    typealias BinderValueType = Double
    
    /// It is computed property, it associate bindable object with UI control.
    var binder: Observable<BinderValueType> {
        get {
            guard let observer = objc_getAssociatedObject(self, &AssociatedKeys.binder) as? Observable<BinderValueType> else {
                let observer = Observable<BinderValueType>()
                objc_setAssociatedObject(self, &AssociatedKeys.binder, observer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return observer
            }
            return observer
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.binder, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //// MARK: - Bindable methods
    
    func update(value binderValue: Double) {
        value = Float(value)
    }
    
    func observingValue() -> Double? {
        return Double(value)
    }
    
    func bind(_ observer: Observable<Double>) {
        addTarget(self, action: #selector(valueChanged), for: [.touchUpInside, .touchUpOutside, .touchDragExit, .touchCancel])
        binder = observer
    }
    
    // MARK: - Instance Methods
    
    
    /// It is called on value change.
    @objc func valueChanged() {
        if binder.value != observingValue() {
            setBinder(withValue: observingValue())
        }
    }
    
    /// It set binder value.
    ///
    /// - Parameter explicitValue: value to be set into binder value property.
    func setBinder(withValue explicitValue : BinderValueType?) {
        binder.value = explicitValue
    }
    
    
    /// It return value associated with binder.
    ///
    /// - Returns: Optional binder value.
    func getBinderValue() -> BinderValueType? {
        return binder.value
    }
}
