//
//  NavHeader.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import SwiftUI

struct NavHeader: View {
    var title: String
    var action: () -> Void
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            Text(title)
                .font(type: .black ,size: 22)
                .foregroundStyle(.white)
            Spacer()
            Rectangle()
                .opacity(0)
                .frame(width: 20, height: 20)
        }
    }
}
