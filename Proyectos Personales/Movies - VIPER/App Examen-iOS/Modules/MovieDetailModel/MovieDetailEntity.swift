//
//  MovieDetailEntity.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.
//

import Foundation

struct MovieDetail: Codable {
    // Identificador
    let id: Int
    // Título
    let title: String
    // Lenguaje original
    let originalLanguage: String
    // Descripcion
    let overview: String
    // Fecha de lanzamiento
    let releaseDate: String
    // Duración de la pelicula
    let runtime: Int?
    // Idiomas - idioma original
    let spokenLanguages: [SpokenLanguage]
    // Ruta del poster
    let posterPath: String?
    // Compañías de producción - pais de origen
    let productionCompanies: [ProductionCompany]
    // Generos
    let genres: [Genre]
    // Página web oficial
    let homepage: String?
    // Promedio de votos
    let voteAverage: Double
    // Numero de votos
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id, title
        case originalLanguage = "original_language"
        case overview
        case releaseDate = "release_date"
        case runtime
        case spokenLanguages = "spoken_languages"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case genres, homepage
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    // Para obtener los nombres de los generos como string
    var genreNames: String {
        genres.map { $0.name }.joined(separator: ", ")
    }
    
    // Para obtener los lenguajes como string
    var languajes: String {
        spokenLanguages.map { $0.name }.joined(separator: ", ")
    }
}

struct Genre: Codable {
    let id: Int
    // Nombre del genero
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    // País de origen
    let originCountry: String

  
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct SpokenLanguage: Codable {
    let englishName: String
    let iso639_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        // Idioma origen
        case name
    }
}
