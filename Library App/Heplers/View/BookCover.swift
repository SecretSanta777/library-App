//
//  BookCover.swift
//  Library App
//
//  Created by Владимир Царь on 26.10.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookCover2: View {
    var coverID: String?
    var body: some View {
        if let coverID, let url = URL(string: "https://covers.openlibrary.org/b/id/\(coverID)-M.jpg") {
            WebImage(url: url)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .clipShape(.rect(cornerRadius: 3))
        } else {
            Image(.book1)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(.rect(cornerRadius: 3))
        }
    }
}

enum ImageType {
    case local(UIImage)
    case network(String?)
}

struct BookCover: View {
    
    var image: ImageType
    var body: some View {
        switch image {
        case .local(let uIImage):
            Image(uiImage: uIImage)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 180)
                .clipShape(.rect(cornerRadius: 3))
        case .network(let urlStr):
            if let urlStr, let uRL = URL(string: "https://covers.openlibrary.org/b/id/\(urlStr)-M.jpg") {
                WebImage(url: uRL)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 180)
                    .clipShape(.rect(cornerRadius: 3))
            } else {
                Image(.book1)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(.rect(cornerRadius: 3))
            }
        }

    }
}
