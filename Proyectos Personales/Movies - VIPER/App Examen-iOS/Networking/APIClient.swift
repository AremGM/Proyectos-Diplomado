//
//  APIClient.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 16/04/25.
//

import Foundation

protocol MovieAPIClientProtocol {
    func fetchMovies(category: String, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void)
}



class MovieAPIClient: MovieAPIClientProtocol {
    private let apiKey: String
    
    init() {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "MoviesAPIKey") as? String else {
            fatalError("API key is missing in Info.plist")
        }
        self.apiKey = key
    }
    
    func fetchMovies(category: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(category)?api_key=\(apiKey)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0)))
                return
            }
            
            do {
                let movies = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(movies.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0)))
                return
            }
            
            do {
                let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                completion(.success(movieDetail))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


