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
    }
    
    func loadWebView(){
        if let safeUrl = articleURL {
            let url = URL(string: safeUrl)
            let requestObj = URLRequest(url: url! as URL)
            
            /*
             Handling in async, throwing security issue.
             This appears to be a new issue with xcode,
             awaiting a bug fix.
             
             source: https://stackoverflow.com/questions/74038451/in-xcode-14-ios-16-purple-warnings-starting-with-this-method-should-not-be-ca
             */
            
            DispatchQueue.main.async {
            self.webView.load(requestObj)
            }
        }
        
    }

}
