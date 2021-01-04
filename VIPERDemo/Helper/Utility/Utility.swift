//
//  Utility.swift
//  GoFigure
//
//  Created by Cybage on 8/30/18.
//  Copyright © 2018 Cybage. All rights reserved.
//

import Foundation
import UIKit

struct Utility {
    
//    /// It lock orientation in particular mode.
//    ///
//    /// - Parameter orientation: Orientation.
//    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
//        
//        if let delegate = UIApplication.shared.delegate as? AppDelegate {
//            delegate.orientationLock = orientation
//        }
//    }
    
    /// It lock orientation to specific mode after rotation.
    ///
    /// - Parameters:
    ///   - orientation: Orientation to keep after rotating.
    ///   - rotateOrientation: Orientation
//    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
//        
//        self.lockOrientation(orientation)
//        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
//        UINavigationController.attemptRotationToDeviceOrientation()
//    }
    
    /// It validate email format.
    ///
    /// - Parameter emailStringValue: Email string value.
    /// - Returns: true if succeeded else false.
    static func isValid(email emailStringValue:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStringValue)
    }
    
    /// It converts date to UTC date. It assume caller has provided local date.
    ///
    /// - Parameter date: local date.
    /// - Returns: UTC date
    static func utcForamttedDate(ofDate date : Date) -> Date {
        let seconds = TimeZone.current.secondsFromGMT()
        var timestamp = date.timeIntervalSince1970
        if seconds > 0 {
            timestamp -= Double(seconds)
        } else {
            timestamp += Double(seconds)
        }
        
        let utcFormattedDate = NSDate(timeIntervalSince1970: timestamp) as Date
        return utcFormattedDate
    }
    
    
    
    /// It converts date with considering local time zone. It assume that caller has provided UTC date.
    ///
    /// - Parameter utcDate: UTC date
    /// - Returns: date with local timezone.
    static func localDate(fromUTCDate utcDate : Date) -> Date {
        let seconds = TimeZone.current.secondsFromGMT()
        var timestamp = utcDate.timeIntervalSince1970
        if seconds > 0 {
            timestamp += Double(seconds)
        } else {
            timestamp -= Double(seconds)
        }
        
        let localDate = NSDate(timeIntervalSince1970: timestamp) as Date
        return localDate
    }
    
    
    /// It generates random string
    ///
    /// - Parameter len: length of the random string.
    /// - Returns: random string value.
    static func randomStringWithLength (len : Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        for _ in 0...len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        return randomString as String
    }
    
    
    /// It validates phone format(8312345678).
    ///
    /// - Parameter phoneStringValue: Phone number.
    /// - Returns: true if succeeded else false.
    static func isValid(phone phoneStringValue : String) -> Bool {
        let phoneRegEx = "[0-9]{10}"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: phoneStringValue)
    }
    
    /// It validates zipcode format(41279).
    ///
    /// - ParameterzipCodeStringValue: Zip Code.
    /// - Returns: true if succeeded else false.
    static func isZipCodeValid(zip zipCodeStringValue : String) -> Bool {
        let zipCode = "[0-9]{5}"
        let zipCodeTest = NSPredicate(format:"SELF MATCHES %@", zipCode)
        return zipCodeTest.evaluate(with: zipCodeStringValue)
    }
    
    /// It can be used to get the reference to root controller of the windo.
    ///
    /// - Returns: Root view controller.
    static func rootController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
    /// Makes a call to the lead and it is a common feature, so can be used in bidding and active tiles section for communication purpose
   static func makeCall(phone: String){
        let url = URL (string :"TEL://\(phone)")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
   
    
    
    /// It tells whehter month and year of the day is same as today or not.
    ///
    /// - Parameter day: Date object.
    /// - Returns: true/false.
    static func isMonthYearSameAsToday(forDay day : Date) -> Bool {
        
        let monthOfTheDay = Calendar.current.component(.month, from: day)
        let yearOfTheDay = Calendar.current.component(.year, from: day)
        let monthOfToday = Calendar.current.component(.month, from: Date())
        let yearOfToday = Calendar.current.component(.year, from: Date())
        
        if monthOfToday == monthOfTheDay && yearOfToday == yearOfTheDay {
            return true
        }
        return false
    }
    
}
