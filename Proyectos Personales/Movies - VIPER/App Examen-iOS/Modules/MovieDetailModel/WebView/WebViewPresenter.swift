//
//  WebViewPresenter.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.
//


import Foundation

protocol WebViewPresenterProtocol: AnyObject {
    // Referencia a la vista
    var view: WebViewViewProtocol? { get set }
    // Referencia a la interactor
    var interactor: WebViewInteractorProtocol? { get set }
    // Referencia a la router
    var router: WebViewRouterProtocol? { get set }

    // Método que debe implementarse para manejar la carga inicial de la vista
    func viewDidLoad()
    // Método para asignar el valor de la url
    func configure(with url: URL)
}


class WebViewPresenter: WebViewPresenterProtocol {
    // Referencia a la vista
    weak var view: WebViewViewProtocol?
    // Referencia a la interactor
    var interactor: WebViewInteractorProtocol?
    // Referencia a la router
    var router: WebViewRouterProtocol?

    // URL del homepage
    private var url: URL?

    // Método para configurar la ulr del webview
    func configure(with url: URL) {
        self.url = url
    }

    // Método llamado cuando la vista se carga
    func viewDidLoad() {
        if let url = url {
            view?.loadWebView(with: url)
        }
    }
}
