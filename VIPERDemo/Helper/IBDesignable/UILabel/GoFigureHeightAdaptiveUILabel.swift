//
//  GoFigureHeightAdaptiveUILabel.swift
//  TestSwift
//
//  Created by Cybage on 8/25/18.
//  Copyright © 2018 Cybage. All rights reserved.
//

import Foundation
import UIKit



@IBDesignable class GoFigureHeightAdaptiveUILabel: UILabel {
    
    
    @IBInspectable var minFontSize:CGFloat = 0.0  {
        didSet {
            super.font = fontToFitHeight()
        }
    }
    
    @IBInspectable var maxFontSize:CGFloat = 0.0 {
        didSet {
            super.font = fontToFitHeight()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        super.font = fontToFitHeight()
    }
    
    // Returns an UIFont that fits the new label's height.
    private func fontToFitHeight() -> UIFont {
        
        var minFontSize: CGFloat = self.minFontSize
        var maxFontSize: CGFloat = self.maxFontSize
        var fontSizeAverage: CGFloat = 0
        var textAndLabelHeightDiff: CGFloat = 0
        
        while (minFontSize <= maxFontSize) {
            fontSizeAverage = minFontSize + (maxFontSize - minFontSize) / 2
            
            if let labelText = text {
                
                let labelHeight = frame.size.height
                
                let testStringHeight = labelText.size(
                    withAttributes: [NSAttributedString.Key.font: font.withSize(fontSizeAverage)]
                    ).height
                
                textAndLabelHeightDiff = labelHeight - testStringHeight
                
                if (fontSizeAverage == minFontSize || fontSizeAverage == maxFontSize) {
                    if (textAndLabelHeightDiff < 0) {
                        return font.withSize(fontSizeAverage - 1)
                    }
                    return font.withSize(fontSizeAverage)
                }
                
                if (textAndLabelHeightDiff < 0) {
                    maxFontSize = fontSizeAverage - 1
                    
                } else if (textAndLabelHeightDiff > 0) {
                    minFontSize = fontSizeAverage + 1
                    
                } else {
                    return font.withSize(fontSizeAverage)
                }
            }
        }
        return font.withSize(fontSizeAverage)
    }
}
