//
//  NewsData.swift
//  NewsReader
//
//  Created by Ben Lapidge on 29/12/2022.
//

import Foundation

struct NewsData: Decodable {
    let articles: [Posts]
}


struct Posts: Decodable {
    let title: String
    let author: String?
    let description: String?
    let source: Details
    let url: String
    
}

struct Details: Decodable {
    let id: String?
    let name: String?
    let Name: String?
}
