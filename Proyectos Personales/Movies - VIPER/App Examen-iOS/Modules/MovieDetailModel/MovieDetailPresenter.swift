//
//  MovieDetailPresenter.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.
//

import Foundation

protocol MovieDetailPresenterProtocol {
    // Referencia a la vista
    var view: MovieDetailViewProtocol? { get set }
    // Referencia a la interactor
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    // Referencia a la router
    var router: MovieDetailRouterProtocol? { get set }

    // Método que debe implementarse para manejar la carga inicial de la vista
    func viewDidLoad()
    // Método para asignar el valor del ID
    func configure(with movieId: Int)
}

class MovieDetailPresenter: MovieDetailPresenterProtocol, MovieDetailInteractorOutputProtocol {
    // Referencia  a la vista
    weak var view: MovieDetailViewProtocol?
    // Referencia al interactor
    var interactor: MovieDetailInteractorInputProtocol?
    // Referencia al router
    var router: MovieDetailRouterProtocol?

    // Identificador de la pelicula
    var movieId: Int?

    // Método llamado cuando la vista se carga
    func viewDidLoad() {
        if let movieId = movieId {
            interactor?.fetchMovieDetails(for: movieId)
        }
    }

    // Método para configurar el ID de la pelicula
    func configure(with movieId: Int) {
        self.movieId = movieId
    }

    // MARK: - Métodos de MovieDetailInteractorOutputProtocol

    // Método llamado cuando los detalles de la pelicula se obtienen correctamente
    func didFetchMovieDetails(_ movie: MovieDetail) {
        // Informa a la vista para mostrar los detalles
        view?.showMovieDetails(movie)
    }

    // Método llamado cuando ocurre un error
    func didFailToFetchMovieDetails(with error: Error) {
        // Informa a la vista para mostrar el error
        view?.showError(error)
    }
}
