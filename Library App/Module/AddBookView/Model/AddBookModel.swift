//
//  AddBookModel.swift
//  Library App
//
//  Created by Владимир Царь on 26.10.2025.
//

import Foundation

struct BookModel: Decodable, Hashable {
    let docs: [BookModelItem]
}

struct BookModelItem: Decodable, Hashable {
    let author_name: [String]?
    let cover_i: Int?
    let title: String?
}
