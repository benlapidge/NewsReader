//
//  ArticleTableViewCell.swift
//  NewsReader
//
//  Created by Ben Lapidge on 31/12/2022.
//

import UIKit
import AVFoundation
protocol ArticleTableViewCellDelegate {
    func readButtonPressed(url: String)
    func urlFailedToLoad(error: String)
}

class ArticleTableViewCell: UITableViewCell {
    
    var delegate: ArticleTableViewCellDelegate?
    
    let synthesizer = AVSpeechSynthesizer()
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsPublisherLabel: UILabel!
    var articleURL: String?
    var articleDesc: String?
    
    @IBAction func speakButtonPressed(_ sender: UIButton) {
        
        if articleDesc == nil {
            speak(utterance: newsTitleLabel.text!)
        } else {
            speak(utterance: articleDesc!)
        }
        
    }
    
    @IBAction func readButtonPressed(_ sender: UIButton) {
        if let articleURL = articleURL {
            delegate?.readButtonPressed(url: articleURL)
        } else {
            delegate?.urlFailedToLoad(error: "URL returned nil")
        }
        
        
    }
    func speak(utterance: String){
        let utterance = AVSpeechUtterance(string: utterance)
        let voice = AVSpeechSynthesisVoice(language: "en-GB")
        
        utterance.voice = voice
        synthesizer.speak(utterance)
    }
}
