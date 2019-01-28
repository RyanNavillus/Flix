//
//  MovieTrailerViewController.swift
//  Flix
//
//  Created by Ryan Sullivan on 1/27/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {

    let webView = WKWebView()
    
    var movie: Movie? {
        didSet {
            FlixAPIManager.instance.getVideos(id: movie?.id ?? 0) { (key) in
                if let url = URL(string: "https://www.youtube.com/embed/\(key)?playsinline=1") {
                    let request = URLRequest(url: url)
                    self.webView.load(request)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view = webView
        webView.configuration.allowsInlineMediaPlayback = true
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
