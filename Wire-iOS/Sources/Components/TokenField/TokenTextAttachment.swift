
// Wire
// Copyright (C) 2020 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation

extension TokenTextAttachment {
    
    @objc
    var titleColor: UIColor? {
        if isSelected {
            return tokenField?.tokenSelectedTitleColor
        } else {
            return tokenField?.tokenTitleColor
        }
    }
    
    var titleAttributes: [NSAttributedString.Key : Any?] {
        return [
            NSAttributedString.Key.font: tokenField?.tokenTitleFont,
            NSAttributedString.Key.foregroundColor: titleColor
        ]
    }
    
    var backgroundColor: UIColor? {
        if isSelected {
            return tokenField?.tokenSelectedBackgroundColor
        } else {
            return tokenField?.tokenBackgroundColor
        }
    }
    @objc
    func imageForCurrentToken() -> UIImage? {
        guard let tokenField = tokenField,
            let lineHeight = tokenField.font?.lineHeight,
            let capHeight = tokenField.font?.capHeight else {
            return nil
        }
        
        let imageHeight = ceil(lineHeight)
        let title = token.title.applying(transform: tokenField.tokenTextTransform)
        var tokenMaxWidth = ceil(token.maxTitleWidth - tokenField.tokenOffset - imageHeight)
        // Width cannot be smaller than height
        if tokenMaxWidth < imageHeight {
            tokenMaxWidth = imageHeight
        }
        let shortTitle = shortenedText(forText: title, withAttributes: titleAttributes, toFitMaxWidth: tokenMaxWidth)
        let attributedName = NSAttributedString(string: shortTitle, attributes: titleAttributes)
        
        let size = attributedName.size()
        
        var imageSize = size
        imageSize.height = imageHeight
        
        let delta = ceil((capHeight - imageHeight) * 0.5)
        bounds = CGRect(x: 0, y: delta, width: imageSize.width, height: imageHeight)
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, _: false, _: 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        //TODO: CFRetain(context)
        
        context?.saveGState()
        
        context?.setFillColor(backgroundColor?.cgColor)
        if let CGColor = borderColor?.cgColor {
            context?.setStrokeColor(CGColor)
        }
        if let context = context {
            context.setLineJoin(.round)
        }
        context?.setLineWidth(1)
        
        attributedName.draw(at: CGPoint(x: 0, y: -delta + tokenField.tokenTitleVerticalAdjustment))
        
        let i = UIGraphicsGetImageFromCurrentImageContext()
        
        context?.restoreGState()
        UIGraphicsEndImageContext()
        
        return i
    }
    
    // MARK: - Description
    override open var description: String {
        return String(format: "<\(TokenTextAttachment.self): \(self), name \(token.title)>")
    }
    
    var debugQuickLookObject: UIImage? {
        return image
    }
}
