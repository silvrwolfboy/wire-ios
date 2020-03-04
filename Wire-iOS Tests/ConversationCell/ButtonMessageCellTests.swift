
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

import XCTest
@testable import Wire

final class PollMessageCellTests: ConversationCellSnapshotTestCase {
    
    typealias CellConfiguration = (MockMessage) -> Void
    
    func testThatItRendersButton() {
        verify(message: makeMessage())
    }
    
    // MARK: - Helpers
    
    private func makeMessage(_ config: CellConfiguration? = nil) -> MockMessage {
        let buttonMessage = MockMessageFactory.buttonMessage ///TODO: text shoudl belong to sub-messages
        
        let textMessageData = MockTextMessageData()
        textMessageData.messageText = "Dummy Poll question:"

        buttonMessage.backingTextMessageData = textMessageData
        
        config?(buttonMessage)
        return buttonMessage
    }
}
