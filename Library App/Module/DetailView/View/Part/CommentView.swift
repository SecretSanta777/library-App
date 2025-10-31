//
//  CommentView.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import SwiftUI

struct CommentView: View {
    var note: Note
    var body: some View {
        VStack(alignment: .leading) {
            Text((note.date ?? Date.now).dayNumber)
                .font(size: 12)
                .foregroundStyle(.white)
            Text(note.text ?? "")
                .foregroundStyle(.appGray)
                .font(size: 12)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
        .padding(.horizontal, 21)
        .background(.appDark)
        .clipShape(.rect(cornerRadius: 10))
    }
}

