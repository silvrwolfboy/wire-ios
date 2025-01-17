
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

extension SplitViewController {

    /// return true if right view (mostly conversation screen) is fully visible
    var isRightViewControllerRevealed: Bool {
        switch self.layoutSize {
        case .compact, .regularPortrait:
            return !isLeftViewControllerRevealed
        case .regularLandscape:
            return true
        }
    }

    /// Update layoutSize for the change of traitCollection and the current orientation
    ///
    /// - Parameters:
    ///   - traitCollection: the new traitCollection
    @objc(updateLayoutSizeForTraitCollection:)
    func updateLayoutSize(for traitCollection: UITraitCollection) {
        switch (traitCollection.horizontalSizeClass, UIApplication.shared.statusBarOrientation.isPortrait) {
        case (.regular, true):
            layoutSize = .regularPortrait
        case (.regular, false):
            layoutSize = .regularLandscape
        default:
            layoutSize = .compact
        }
    }
}
