//
//  WebViewController.swift
//  ComicbookUIKit
//
//  Created by Andrei Enea on 03.01.2023.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var comicNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadURL()
        
    }
    
    private func loadURL() {
        // this could be made way safer than this
        guard let comicNumber = comicNumber else {
            return
        }
        let url = URL(string: "https://www.explainxkcd.com/wiki/index.php/\(comicNumber)")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
}
