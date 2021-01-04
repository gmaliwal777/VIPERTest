//
//  GoFigureHeightProportionateUITextView.swift
//  GoFigure
//
//  Created by Cybage on 8/28/18.
//  Copyright © 2018 Cybage. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class GoFigureWidthProportionateUItextView : UITextView {
    
    // MARK: - Instance properties
    
    @IBInspectable var paddingValue: CGFloat = 0
    
    /// It is the standard font size against standard width.
    @IBInspectable var standardFontSize: CGFloat = 1.0 {
        didSet {
            if let proportionateFont = proportionateFont() {
                super.font = proportionateFont
            }
        }
    }
    
    /// It is the standard textView width, against which standard font size is defined.
    @IBInspectable var standardWidth: CGFloat = 1.0 {
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
        if let proportionateFont = proportionateFont() {
            super.font = proportionateFont
        }
    }
    
    
    
    // MARK: - Instance Methods
    
    
    /// It tells about the font where font size is in proportionate to standard UITextView container width.
    ///
    /// - Returns: Font.
    private func proportionateFont() -> UIFont? {
        let dynamicWidth = frame.size.width
        let proportionateFontSize = ( standardFontSize / standardWidth ) * dynamicWidth
        return font?.withSize(proportionateFontSize)
    }
}
