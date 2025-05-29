//
//  MovieListInteractor.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 14/04/25.
//

import UIKit

protocol MovieListInteractorInputProtocol {
    // Referencia al presenter
    var presenter: MovieListInteractorOutputProtocol? { get set }
    // Método para iniciar la obtencion de pelculas
    func fetchMovies(category: String)
}

class MovieListInteractor: MovieListInteractorInputProtocol {
    // Referencia al presenter
    var presenter: MovieListInteractorOutputProtocol?
    //Referencia a las funciones de peticion
    private let apiClient: MovieAPIClientProtocol
    
    init(apiClient: MovieAPIClientProtocol = MovieAPIClient()) {
        self.apiClient = apiClient
    }
    // Método para obtener las peliculas
    func fetchMovies(category: String) {
        apiClient.fetchMovies(category: category) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.presenter?.didFetchMovies(movies)
            case .failure(let error):
                self?.presenter?.didFailToFetchMovies(with: error)
            }
        }
    }
}


protocol MovieListInteractorOutputProtocol: AnyObject {
    // Método llamado cuando las peliculas se obtienen correctamente
    func didFetchMovies(_ movies: [Movie])
    // Método llamado cuando ocurre un error
    func didFailToFetchMovies(with error: Error)
}
