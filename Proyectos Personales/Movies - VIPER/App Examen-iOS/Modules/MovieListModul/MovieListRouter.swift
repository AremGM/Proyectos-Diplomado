//
//  MovieListRouter.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.
//

import UIKit

protocol MovieListRouterProtocol {
    // Método para crear el modulo de la lista de peliculas
    static func createModule() -> UIViewController
    // Método para navegar al detalle de una pelicula
    func navigateToMovieDetail(from view: MovieListViewProtocol, with movie: Int)
}


class MovieListRouter: MovieListRouterProtocol {
    
    static func createModule() -> UIViewController {
        // Instancia de la vista
        let view = MovieListViewController()
        // Instancia del presenter
        let presenter = MovieListPresenter()
        // Instancia del interactor
        let interactor =  MovieListInteractor()
        // Instancia del router
        let router = MovieListRouter()

        // Configuración de las dependencias
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }

    // Método para navegar a MovieDetail
    func navigateToMovieDetail(from view: MovieListViewProtocol, with movieID: Int) {
        let detailViewController = MovieDetailRouter.createModule(with: movieID)
        
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

