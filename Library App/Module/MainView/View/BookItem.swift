//
//  BookItem.swift
//  Library App
//
//  Created by Владимир Царь on 25.10.2025.
//
import SwiftUI

struct BookItem: View {
    var book: Book
    var body: some View {
        HStack {
            Image.getImage(folderName: (book.id)!, fileName: "cover.jpeg")!
                .resizable()
                .frame(width: 64, height: 94)
                .clipShape(.rect(cornerRadius: 3))
            VStack(alignment: .leading, spacing: 9) {
                VStack(alignment: .leading) {
                    Text(book.name ?? "")
                        .font(type: .bold, size: 14)
                    Text(book.author ?? "")
                        .font(type: .medium, size: 12)
                        .foregroundStyle(.appGray)
                    
                }
                Text(book.bookDescription ?? "")
                    .font(type: .medium, size: 14)
            }
            .foregroundStyle(.white)
        }
    }
}

