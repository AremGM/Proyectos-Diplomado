//
//  MovieListEntity.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 14/04/25.
//

import Foundation

struct Movie: Decodable {
    // Identificador
    let id: Int
    // Título
    let title: String
    // Descripción
    let overview: String
    // Ruta del poster
    let posterPath: String?
    // Promedio de votos 
    let voteAverage: Double
    

    // Mapeo de las claves del JSON a las propiedades de la estructura.
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
