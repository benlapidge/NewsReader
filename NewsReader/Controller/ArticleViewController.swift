//
//  ArticleViewController.swift
//  NewsReader
//
//  Created by Ben Lapidge on 29/12/2022.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {

    var articleURL: String?
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
        // Do any additional setup after loading the view.
    }
    
    func loadWebView(){
        if let safeUrl = articleURL {
            let url = URL(string: safeUrl)
            let requestObj = URLRequest(url: url! as URL)
            DispatchQueue.main.async {
            self.webView.load(requestObj)
            }
        }
        
    }

}
