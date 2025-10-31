//
//  BookNetworkManager.swift
//  Library App
//
//  Created by Владимир Царь on 26.10.2025.
//

import Foundation

class BookNetworkManager {
    
    let url = "https://openlibrary.org/search.json"
    
    func searchBookRequest(q: String, completion: @escaping (Result<[BookModelItem], Error>) -> Void) {
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "fields", value: "title,author_name,cover_i,subtitle,number_of_pages,median,first_publish_year,rating_count"),
            URLQueryItem(name: "lang", value: "ru"),
            
        ]
        
        guard let url = urlComponents?.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                print(error?.localizedDescription)
                completion(.failure(error!))
                return
            }
            
            guard let data else { return }
            
            do {
                let books = try JSONDecoder().decode(BookModel.self, from: data)
                completion(.success(books.docs))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    
}
