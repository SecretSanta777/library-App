//
//  BookListViewContent.swift
//  Library App
//
//  Created by Владимир Царь on 24.10.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookListViewContent: View {
    
    let books: [BookModelItem]
    var completion: (BookModelItem) -> Void
    var goBack: () -> Void
    
    var body: some View {
        ZStack(alignment: .top) {
            NavHeader(title: books.first?.title ?? "") {
                goBack()
            }
            
            ScrollView(.vertical ,showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Результаты поиска")
                        .foregroundStyle(.white)
                        .font(size: 14)
                        .padding(.horizontal, 21)
                    VStack(alignment: .leading, spacing: 23) {
                        ForEach(books, id: \.self) { book in
                            BookListItemView(book: book) {
                                completion(book)
                            }
                        }
                    }
                }
            }
            .padding(.top, 44)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 30)
        .background(.bgMain)
    }
}

struct PreviewDevider_BookListViewContent: PreviewProvider {
    static var previews: some View {
        BookListViewContent(books: [BookModelItem(author_name: ["asdasdad"], cover_i: 1231231, title: "adsadsadsads")]) { _ in
            
        } goBack: {
            //
        }
    }
}
