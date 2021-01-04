//
//  GoFigureHeightProportionateUITextField.swift
//  GoFigure
//
//  Created by Cybage on 8/28/18.
//  Copyright © 2018 Cybage. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class GoFigureHeightProportionateUItextField : UITextField {
    
    // MARK: - Instance properties
    
    @IBInspectable var paddingValue: CGFloat = 0
    
    /// It is the standard font size against standard height.
    @IBInspectable var standardFontSize: CGFloat = 1.0 {
        didSet {
            if let proportionateFont = proportionateFont() {
                super.font = proportionateFont
            }
        }
    }
    
    /// It is the standard textfield height, against which standard font size is defined.
    @IBInspectable var standardHeight: CGFloat = 1.0 {
        didSet {
            if let proportionateFont = proportionateFont() {
                super.font = proportionateFont
            }
        }
    }
    
    
    /// left & right side padding.
    var padding : UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: paddingValue, bottom: 0.0, right: paddingValue)
    }
    
    
    // MARK: - UITextField class life cycle.
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        _ = initialUserInterfaceSetupClosure
    }
    

    /// It setup initial user interface for the textfield context
    lazy var initialUserInterfaceSetupClosure : () = {
        setLeftPaddingPoints()
        setRightPaddingPoints()
        if let proportionateFont = proportionateFont() {
            font = proportionateFont
            contentVerticalAlignment = .center
        }
    }()
    
    // MARK: - Instance Methods
    
    /// It is useful to provide left side padding
    private func setLeftPaddingPoints(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingValue, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    /// It is useful to provide right side padding
    private func setRightPaddingPoints() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingValue, height: frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
    
    
    /// It tells about the font where font size is proportionate to standard height of UITextField.
    ///
    /// - Returns: Font.
    private func proportionateFont() -> UIFont? {
        let dynamicHeight = frame.size.height
        let proportionateFontSize = ( standardFontSize / standardHeight ) * dynamicHeight
        return font?.withSize(proportionateFontSize)
    }
}
