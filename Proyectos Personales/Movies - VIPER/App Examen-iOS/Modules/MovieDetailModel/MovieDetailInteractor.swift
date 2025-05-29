//
//  MovieDetailInteractor.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.
//

import Foundation

protocol MovieDetailInteractorInputProtocol {
    // Referencia al presenter
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    // Método para iniciar la obtencion de los detalles
    func fetchMovieDetails(for movieId: Int)
}


class MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    // Referencia al presenter
    weak var presenter: MovieDetailInteractorOutputProtocol?
    //Referencia a las funciones de peticion
    private let apiClient: MovieAPIClientProtocol

    init(apiClient: MovieAPIClientProtocol = MovieAPIClient()) {
        self.apiClient = apiClient
    }
    // Método para obtener los detalles de una pelicula
    func fetchMovieDetails(for movieId: Int) {
        apiClient.fetchMovieDetails(movieId: movieId) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.presenter?.didFetchMovieDetails(movieDetail)
            case .failure(let error):
                self?.presenter?.didFailToFetchMovieDetails(with: error)
            }
        }
    }

}



// Funciones para devolver los datos obtenidos
protocol MovieDetailInteractorOutputProtocol: AnyObject {
    // Método llamado cuando los detalles se obtienen correctamente
    func didFetchMovieDetails(_ movie: MovieDetail)
    // Método llamado cuando ocurre un error
    func didFailToFetchMovieDetails(with error: Error)
}
