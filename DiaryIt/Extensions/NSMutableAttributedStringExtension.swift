//
//  NSMuttableAttributedStringExtension.swift
//  DiaryIt
//
//  Created by Rinni Swift on 3/22/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func setFont() {
        let font = UIFont(name: "Avenir-Book", size: 17)
        let color = UIColor(red:0.42, green:0.42, blue:0.42, alpha:1.0)
        
        beginEditing()
        self.enumerateAttribute(.font, in: NSRange(location: 0, length: self.length)) { value, range, stop in
            if let f = value as? UIFont {
                let newFontDescriptor = f.fontDescriptor.withFamily((font?.familyName)!).withSymbolicTraits(f.fontDescriptor.symbolicTraits)
                let newFont = UIFont(descriptor: newFontDescriptor!, size: (font?.pointSize)!)
                removeAttribute(.font, range: range)
                addAttribute(.font, value: newFont, range: range)
                
                removeAttribute(.foregroundColor, range: range)
                addAttribute(.foregroundColor, value: color, range: range)
            }
        }
        endEditing()
    }
    
}
