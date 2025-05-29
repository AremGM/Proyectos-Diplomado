//
//  WebViewRouter.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.
//


import UIKit

protocol WebViewRouterProtocol: AnyObject {
    // Método para crear el modulo del webview
    static func createModule(with url: URL) -> UIViewController
}

class WebViewRouter: WebViewRouterProtocol {
    static func createModule(with url: URL) -> UIViewController {
        // Instancia de la vista
        let view = WebViewController()
        // Instancia de la presenter
        let presenter = WebViewPresenter()
        // Instancia de la interactor
        let interactor = WebViewInteractor()
        // Instancia de la router
        let router = WebViewRouter()

        // Configuración de las dependencias
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.configure(with: url)
        interactor.presenter = presenter

        return view
    }
}


