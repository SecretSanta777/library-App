//
//  ViewExt.swift
//  Library App
//
//  Created by Владимир Царь on 21.10.2025.
//

import SwiftUI

extension View {
    func font(type: FontType = .regular, size: CGFloat = 14) -> some View {
        modifier(CustomFont(font: type, size: size))
    }
}
