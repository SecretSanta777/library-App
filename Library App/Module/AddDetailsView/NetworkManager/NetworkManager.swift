//
//  NetworkManager.swift
//  Library App
//
//  Created by Владимир Царь on 26.10.2025.
//

import Foundation

class NetworkManager {
    let url = "https://bothub.chat/api/v2/openai/v1/chat/completions"
    let token = "eyJhbGcioiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWVmMzI9LTc1NmUtNDV10C84YWYxLTFIMWNKkMDRkMDE1NyIsIm1zRGV2ZWxvcGVyIjpecnVILCJpYXQi0jE3MzUzOTA3NjIsImV4cCI6MjA1MDk2Njc2Mn8.xL2fhtLOtHp_K4Xn_bEAhukgnRwY1UGwaRk-XxirgdY"
    
    func sendRequest(bookName: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBodyStruct = BotHubResponse(message: [Message(role: "user", content: "Опиши книгу \(bookName) в 3 - 5 предложений")])
        
        do {
            let requestBody = try JSONEncoder().encode(requestBodyStruct)
            request.httpBody = requestBody
        } catch {
            print(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else { return }
            
            guard let data else { return }
            
            do {
                let responce = try JSONDecoder().decode(ChatResponse.self, from: data)
                completion(responce.choices[0].message.content)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    func loadCover(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.addValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, resp, error in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            guard let httpResp = resp as? HTTPURLResponse, httpResp.statusCode == 200 else {
                completion(.failure(SaveError.misingCover))
                return
            }
            
            guard let data else {
                completion(.failure(SaveError.missingData))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
}


struct BotHubResponse: Encodable {
    let model: String = "gpt-4o"
    let message: [Message]
}

struct Message: Codable {
    let role: String
    let content: String
}

struct ChatResponse: Decodable {
    let choices: [CharResponseChoice]
}

struct CharResponseChoice: Decodable {
    let message: Message
}

