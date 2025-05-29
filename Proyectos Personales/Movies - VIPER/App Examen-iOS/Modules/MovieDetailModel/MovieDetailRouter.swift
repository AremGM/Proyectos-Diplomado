//
//  MovieDetailRouter.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.
//

import UIKit

protocol MovieDetailRouterProtocol {
    // Método para crear el modulo de la pelicula
    static func createModule(with movie: Int) -> UIViewController
    // Método para navegar al webview
    func navigateToWebView(from view: UIViewController, with url: URL)
}

class MovieDetailRouter: MovieDetailRouterProtocol {
    
    static func createModule(with movie: Int) -> UIViewController {
        // Instancia de la vista
        let view = MovieDetailViewController()
        // Instancia del presenter
        let presenter = MovieDetailPresenter()
        // Instancia del interactor
        let interactor = MovieDetailInteractor()
        // Instancia del router
        let router = MovieDetailRouter()

        // Configuración de las dependencias
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.configure(with: movie)
        interactor.presenter = presenter

        return view
    }
    
    // Método para navegar a webview
    func navigateToWebView(from view: UIViewController, with url: URL) {
        let webViewModule = WebViewRouter.createModule(with: url)
        view.navigationController?.pushViewController(webViewModule, animated: true)
    }
}
