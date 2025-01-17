//
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

/// A helper class that provides a reference to the current self user.

public class SelfUser {

    /// The underlying provider of the self user.

    public static var provider: SelfUserProvider?

    /// The current self user.
    ///
    /// Calling this property will intentionally crash if the `provider` is not configured. This is a
    /// tradeoff for the convenience of not needing to unwrap the self user, as it is available in the
    /// majority of the codebase. For safe access, go through the provider instead.

    public class var current: UserType & ZMEditableUser {
        guard let provider = provider else { fatalError("Self user provider not set") }
        return provider.selfUser
    }
}
