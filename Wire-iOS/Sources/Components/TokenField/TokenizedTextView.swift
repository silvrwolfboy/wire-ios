
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

extension TokenizedTextView {
    // MARK: - Utils
    @objc(pasteboardStringFromRange:)
    func pasteboardString(from range: NSRange) -> String? {
        // enumerate range of current text, resolving person attachents with user name.
        var string = ""
        for i in range.location..<NSMaxRange(range) {
            guard let plainString: NSString = attributedText?.string as NSString? else { continue }
            
            let char = plainString.character(at: i)
            
            if char == NSTextAttachment.character {
                let tokenAttachemnt = attributedText?.attribute(.attachment, at: i, effectiveRange: nil) as? TokenTextAttachment
                string += tokenAttachemnt?.token.title ?? ""
                if i < NSMaxRange(range) - 1 {
                    string += ", "
                }
            } else {
                string += (attributedText?.string as NSString?)?.substring(with: NSRange(location: i, length: 1)) ?? ""
            }
        }
        
        return string
    }
}
