//
//  WebView.swift
//  ipadWebBrowser
//
//  Created by Arnur Sakenov on 30.03.2023.
//

import UIKit
import WebKit

protocol WebViewDelegate: AnyObject {
    func addToFavorite(_ isFavorite: Bool)
}

class WebViewController: UIViewController {

    weak var delegate: WebViewDelegate?
    private var webView: WKWebView!
    private var activityIndicator: UIActivityIndicatorView!
    var isFavorite: Bool?
    var favoriteIsHidden: Bool = false
    private var url: URL?
    private var favoriteButton: UIBarButtonItem!

    init(delegate: WebViewDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setInterface()
        setConstraints()
        if let url = URL(string: "https://www.google.com/") {
            loadURL(url)
        }

        favoriteButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(addToFavorite))
        favoriteButton.tintColor = .systemBlue
        if !favoriteIsHidden {
            favoriteButton.image = nil
        } else {
            uploadIcon()
        }
        navigationItem.rightBarButtonItem = favoriteButton
       
    }

    @objc func addToFavorite() {
        if let delegate = delegate, let isFavorite = isFavorite {
            delegate.addToFavorite(!isFavorite)
            updateFavoriteButton(isFavorite: !isFavorite)
        } else {
            print("delegate is nil")
        }
    }
}


extension WebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }

    func loadURL(_ url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }

    func uploadIcon() {
        let imageName = isFavorite == true ? "star.fill" : "star"
        favoriteButton.image = UIImage(systemName: imageName)
    }

    func updateFavoriteButton(isFavorite: Bool) {
        self.isFavorite = isFavorite
        uploadIcon()
    }

    private func setInterface() {
        webView = WKWebView(frame: view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        view.addSubview(webView)
        view.addSubview(activityIndicator)
    }

    private func setConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}

