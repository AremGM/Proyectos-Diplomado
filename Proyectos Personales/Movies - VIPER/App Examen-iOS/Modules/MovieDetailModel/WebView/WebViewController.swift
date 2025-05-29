//
//  WebViewController.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.
//

import Foundation
import UIKit
import WebKit

// Protocolo para la vista WebView
protocol WebViewViewProtocol: AnyObject {
    // Cargar el webview
    func loadWebView(with url: URL)
}

class WebViewController: UIViewController, WebViewViewProtocol {
    // WebView
    private var webView: WKWebView!
    // Referencia al presenter
    var presenter: WebViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        presenter?.viewDidLoad()
    }

    //Configuraciones en la vista
    private func setupWebView() {
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // Carga de webview
    func loadWebView(with url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

