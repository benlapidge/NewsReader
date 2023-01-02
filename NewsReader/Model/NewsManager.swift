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
        let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let today = dateFormatter.string(from: date)
        if let url = URL(string: "\(apiURL)\(query)&apikey=\(Constants.newsApiKey)&language=\(Constants.language)&from=\(today)&sortBy=publishedAt"){
            print(url)
            
            
            //let session = URLSession(configuration: .default)
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let news = try decoder.decode(NewsData.self, from: safeData)
                            DispatchQueue.main.async {
                                delegate?.didLoadNewsArticles(news: [news])
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
