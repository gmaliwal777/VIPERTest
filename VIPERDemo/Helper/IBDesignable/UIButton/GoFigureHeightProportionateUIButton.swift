//
//  GoFigureHeightProportionateUIButton.swift
//  TestSwift
//
//  Created by Cybage on 8/25/18.
//  Copyright © 2018 Cybage. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class GoFigureWidthProportionateUIButton : UIButton {
    
    //// MARK: - Instance Properties
    
    /// It is the standard font size against standard height.
    @IBInspectable var standardFontSize: CGFloat = 1.0 {
        didSet {
            if let proportionateFont = proportionateFont() {
                titleLabel?.font = proportionateFont
            }
        }
    }
    
    /// It is the standard button height, against which standard font size is defined.
    @IBInspectable var standardButtonWidth: CGFloat = 1.0 {
        didSet {
            if let proportionateFont = proportionateFont() {
                titleLabel?.font = proportionateFont
            }
        }
    }
    
    
    // MARK: - UILabel class life cycle.
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let proportionateFont = proportionateFont() {
            titleLabel?.font = proportionateFont
        }
    }
    
    // MARK: - Instance Methods
    
    /// It tells about the font where font size is proportionate to standard height.
    ///
    /// - Returns: Font.
    private func proportionateFont() -> UIFont? {
        let dynamicWidth = frame.size.width
        let proportionateFontSize = ( standardFontSize / standardButtonWidth ) * dynamicWidth
        return titleLabel?.font.withSize(proportionateFontSize)
    }
}


@IBDesignable class GoFigureHeightProportionateUIButton : UIButton {
    
    // MARK: - Instance properties
    
    /// It is the standard font size against standard height.
    @IBInspectable var standardFontSize: CGFloat = 1.0 {
        didSet {
            if let proportionateFont = proportionateFont() {
                titleLabel?.font = proportionateFont
            }
        }
    }
    
    /// It is the standard button height, against which standard font size is defined.
    @IBInspectable var standardButtonHeight: CGFloat = 1.0 {
        didSet {
            if let proportionateFont = proportionateFont() {
                titleLabel?.font = proportionateFont
            }
        }
    }
    
    // MARK: - UIButton class life cycle.
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let proportionateFont = proportionateFont() {
            titleLabel?.font = proportionateFont
        }
    }
    
    // MARK: - Instance Methods
    
    /// It tells about the font where font size is proportionate to standard height.
    ///
    /// - Returns: Font.
    private func proportionateFont() -> UIFont? {
        let dynamicButtonHeight = frame.size.height
        let proportionateFontSize = ( standardFontSize / standardButtonHeight ) * dynamicButtonHeight
        return titleLabel?.font.withSize(proportionateFontSize)
    }
}
