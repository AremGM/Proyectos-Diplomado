//
//  MovieListPresenter.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 14/04/25.
//

import UIKit

protocol MovieListPresenterProtocol {
    // Referencia a la vista
    var view: MovieListViewProtocol? { get set }
    // Referencia al interactor
    var interactor: MovieListInteractorInputProtocol? { get set }
    // Referencia al router
    var router: MovieListRouterProtocol? { get set }

    // Método que debe implementarse para manejar la carga inicial de la vista
    func viewDidLoad(category: String)
}

class MovieListPresenter: MovieListPresenterProtocol, MovieListInteractorOutputProtocol {
   
    // Referencia a la vista
    weak var view: MovieListViewProtocol?
    // Referencia al interactor
    var interactor: MovieListInteractorInputProtocol?
    // Referencia al router
    var router: MovieListRouterProtocol?

    // Método llamado cuando la vista se carga
    func viewDidLoad(category: String) {
        // Solicita al interactor que obtenga las peliculas
        interactor?.fetchMovies(category: category)
    }

    // MARK: - Métodos de MovieListInteractorOutputProtocol
    
    // Método llamado cuando las peliculas se obtienen correctamente
    func didFetchMovies(_ movies: [Movie]) {
        // Informa a la vista 
        view?.showMovies(movies)
    }

    // Método llamado cuando ocurre un error al obtener las peliculas
    func didFailToFetchMovies(with error: Error) {
        // Informa a la vista
        view?.showError(error)
    }
}


