//
//  Observable.swift
//  GoFigure
//
//  Created by Cybage on 8/29/18.
//  Copyright © 2018 Cybage. All rights reserved.
//
import Foundation



class Observable<ObservedType> {
    
    //// MARK: - Custom type
    
    /// It is the closure based callback type, all observers are of below type
    typealias Observer = (_ observable: Observable<ObservedType>,ObservedType?) -> Void
    
    // MARK: - Instance Properties
    
    /// Array of all observers, who want to listen change in the value.
    
    
    /// Collection of observers.
    private var observers = [Observer]()
    
    
    /// Observer value.
    var value : ObservedType? {
        didSet {
            //Change in the value.
            notify(observer: value)
        }
    }
    
    //// MARK: - Initializers
    
    init(initialValue value : ObservedType? = nil) {
        self.value = value
    }
    
    
    //// MARK: - Instance Methods
    
    /// It keep observer in the stack to notify it later on change in the value.
    ///
    /// - Parameter observer: Block/Closure.
    func bind(_ observer : @escaping Observer) {
        observers.append(observer)
    }
    
    
    /// It notify observers with changed value.
    ///
    /// - Parameter updatedValue: Updated value
    private func notify(observer updatedValue: ObservedType?) {
        observers.forEach { (observer) in
            observer(self, updatedValue)
        }
    }
    
}

extension Observable where ObservedType == String {
    func trimmedValue() -> ObservedType? {
        return value?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
