//
//  BookListItemView.swift
//  Library App
//
//  Created by Владимир Царь on 26.10.2025.
//

import SwiftUI

struct BookListItemView: View {
    var book: BookModelItem
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .top, spacing: 13) {

                BookCover(image: .network(book.cover_i?.description))
                
                VStack(alignment: .leading) {
                    Text(book.title ?? "-")
                        .foregroundStyle(.white)
                        .font(type: .black, size: 16)
                    Text(book.author_name?.first ?? "-")
                        .foregroundStyle(.appGray)
                        .font(type: .medium, size: 14)
                }
                .padding(.top, 10)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white)
                    .padding(.top, 10)
                
            }
        }
    }
}
