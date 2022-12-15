//
//  APICaller.swift
//  News World
//
//  Created by Arman Merchant on 2022-10-30.
//

import Foundation

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = "https://newsapi.org/v2/top-headlines?apiKey=06d2e4db2dc54f51977bd6e28268b9c0&country=%@&category=%@"
        
        static let searchUrlString = "https://newsapi.org/v2/everything?sortBy=publishedAt&apiKey=06d2e4db2dc54f51977bd6e28268b9c0&q=%@"
    }
    
    private init() {}
    
    public func getTopStories(category: String = "general", country: String = "in",completion: @escaping(Result<[Article], Error>) -> Void) {
        let urlStr = String.init(format: Constants.topHeadlinesURL, country, category)
        guard  let url = URL(string: urlStr) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    guard let articles =  result.articles else { return }
                    print("Articles: \(articles.count)")
                    completion(.success(articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    
    public func search(with query: String, completion: @escaping(Result<[Article], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let urlString = String.init(format: Constants.searchUrlString,  query)
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    guard let articles = result.articles else { return }
                    print("Articles: \(articles.count)")
                    completion(.success(articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    
}






//Models

struct APIResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

struct Source: Codable {
    let id: String?
    let name: String?
}
