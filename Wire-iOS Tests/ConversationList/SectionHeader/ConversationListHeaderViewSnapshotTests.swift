//
// Wire
// Copyright (C) 2019 Wire Swiss GmbH
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

import SnapshotTesting
import XCTest
@testable import Wire

final class ConversationListHeaderViewSnapshotTests: XCTestCase {
    
    var sut: ConversationListHeaderView!
    
    override func setUp() {
        super.setUp()

        sut = ConversationListHeaderView(frame: CGRect(origin: .zero, size: CGSize(width: 320, height: CGFloat.ConversationListSectionHeader.height)))

        sut.title = "THISISAVERYVERYVERYVERYVERYVERYVERYVERYLONGFOLDERNAME"

        sut.backgroundColor = .black
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()        
    }
    
    func testForExpanded() {
        verify(matching: sut)
    }

    func testForCollapsed() {
        sut.collapsed = true
        
        verify(matching: sut)
    }
    
    func testForBadgeNumberHitDisplayLimit() {
        sut.folderBadge = 999
        verify(matching: sut)
    }
}
