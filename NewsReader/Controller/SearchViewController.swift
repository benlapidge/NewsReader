//
//  ViewController.swift
//  NewsReader
//
//  Created by Ben Lapidge on 29/12/2022.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource {
    
    var articleURL: String?
    var newsManager = NewsManager()
    var posts: [NewsData]?
    
    //MARK: - IBOutlets
    @IBOutlet weak var articleTable: UITableView!
    @IBOutlet weak var searchQueryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchQueryTextField.delegate = self
        articleTable.dataSource = self
        newsManager.delegate = self
    }
    
    //MARK: - IBActions
    
    @IBAction func findButtonPressed(_ sender: UIButton) {
        
        if let query = searchQueryTextField.text{
            newsManager.fetchNews(query: query)
        } else {
            searchQueryTextField.placeholder = "Please enter a query"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.webViewSegue {
            let destinationVC = segue.destination as! ArticleViewController // Downcast to designated viewcontroller class desired. The ! means it will be FORCED.
            if let articleURL = articleURL {
                destinationVC.articleURL = articleURL
            }
            
        }
    }
    
}

//MARK: - UITable View Delegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?[0].articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! ArticleTableViewCell
        cell.delegate = self
        let article = posts![0].articles[indexPath.row]
        cell.newsTitleLabel.text = article.title
        
        cell.articleURL = article.url
        
        if article.source.name != nil {
            cell.newsPublisherLabel.text = article.source.name
        } else if article.source.Name != nil {
            cell.newsPublisherLabel.text = article.source.Name
        }
        
        if article.description != nil {
            cell.articleDesc = article.description
        }
        return cell
    }
}

//MARK: - ArticleTableViewDelegate
extension SearchViewController: ArticleTableViewCellDelegate {
    
    func readButtonPressed(url: String) {
        articleURL = url
        self.performSegue(withIdentifier: Constants.webViewSegue, sender: self)
    }
    func urlFailedToLoad(error: String) {
        print(error)
    }
}
//MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let query = textField.text {
            newsManager.fetchNews(query: query)
        }
        searchQueryTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let query = textField.text {
            newsManager.fetchNews(query: query)
        }
        searchQueryTextField.text = ""
    }
}

//MARK: - NewsManagerDelegate

extension SearchViewController: NewsManagerDelegate {
    func didLoadNewsArticles(news: [NewsData]) {
        posts = news
        articleTable.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
