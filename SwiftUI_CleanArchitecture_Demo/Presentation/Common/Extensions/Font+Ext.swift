//
//  Font+Ext.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import SwiftUI
import UIKit

extension Font {

    static func current(weight: Font.Weight, size: CGFloat) -> Font {
        let isIPad = UIDevice.current.userInterfaceIdiom == .pad
        let adjustedSize = isIPad ? size * 1.2 : size
        return .system(size: adjustedSize, weight: weight)
    }

    static func currentLargeTitle() -> Font { .current(weight: .bold, size: 34) }
    static func currentTitle() -> Font { .current(weight: .semibold, size: 22) }
    static func currentHeadline() -> Font { .current(weight: .semibold, size: 17) }
    static func currentBody() -> Font { .current(weight: .regular, size: 17) }
    static func currentCaption() -> Font { .current(weight: .regular, size: 12) }
    static func currentFootnote() -> Font { .current(weight: .regular, size: 13) }
}

extension UIFont {

    static func current(weight: UIFont.Weight, size: CGFloat) -> UIFont {
        let isIPad = UIDevice.current.userInterfaceIdiom == .pad
        let adjustedSize = isIPad ? size * 1.2 : size
        return .systemFont(ofSize: adjustedSize, weight: weight)
    }
}
