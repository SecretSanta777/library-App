//
//  CustomFont.swift
//  Library App
//
//  Created by Владимир Царь on 21.10.2025.
//

import SwiftUI

struct CustomFont: ViewModifier {
    var font: FontType
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom(font.rawValue, size: size))
    }
}
