//
//  ViewController.swift
//  NewsReader
//
//  Created by Ben Lapidge on 29/12/2022.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, NewsManagerDelegate, UITableViewDelegate, ArticleTableViewCellDelegate {
  
    
   
    var articleURL: String?
    var newsManager = NewsManager()
    var posts: [NewsData]?
    //MARK: - IBOutlets
    
    @IBOutlet weak var articleTable: UITableView!
    @IBOutlet weak var searchQueryTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTable.dataSource = self
        newsManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func findButtonPressed(_ sender: UIButton) {
        
        if let query = searchQueryTextField.text{
            newsManager.fetchNews(query: query)
        } else {
            searchQueryTextField.placeholder = "Please enter a query"
        }
        
    }
    
    func didLoadNewsArticles(news: [NewsData]) {
        print(news)
        posts = news
        articleTable.reloadData()
    }

    func didFailWithError(error: Error) {
        print(error)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?[0].articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! ArticleTableViewCell
        cell.delegate = self
        cell.newsTitleLabel.text = posts![0].articles[indexPath.row].title
        cell.newsPublisherLabel.text = posts![0].articles[indexPath.row].source.Name
        cell.articleURL = posts![0].articles[indexPath.row].url
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
    
    func readButtonPressed(url: String) {
        articleURL = url
        self.performSegue(withIdentifier: Constants.webViewSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.webViewSegue {
            let destinationVC = segue.destination as! ArticleViewController // Downcast to designated viewcontroller class desired. The ! means it will be FORCED.
            if let articleURL = articleURL {
                destinationVC.articleURL = articleURL
            }
            
        }
    }
    
    func urlFailedToLoad(error: String) {
        print(error)
    }
    
}


extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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



