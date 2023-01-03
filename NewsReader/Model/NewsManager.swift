//
//  NewsManager.swift
//  NewsReader
//
//  Created by Ben Lapidge on 29/12/2022.
//

import UIKit
import AVFoundation

protocol NewsManagerDelegate{
    func didLoadNewsArticles(news: [NewsData])
    func didFailWithError(error: Error)
}

struct NewsManager {
    var delegate: NewsManagerDelegate?
    let apiURL = "https://newsapi.org/v2/everything?q="
    
    func fetchNews(query: String){
        
        // trims spaces
        let trimmedQuery = query.trimmingCharacters(in: .whitespaces)
        
        // gets current date and strips time
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: date)
        
        
        // Async API call
        if let url = URL(string: "\(apiURL)\(trimmedQuery)&apikey=\(Constants.newsApiKey)&language=\(Constants.language)&from=\(today)&sortBy=publishedAt&searchIn=title"){
            print(url)
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let news = try decoder.decode(NewsData.self, from: safeData)
                            DispatchQueue.main.async {
                                delegate?.didLoadNewsArticles(news: [news]) // Returns posts to search VC 
                            }
                        } catch {
                            delegate?.didFailWithError(error: error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
