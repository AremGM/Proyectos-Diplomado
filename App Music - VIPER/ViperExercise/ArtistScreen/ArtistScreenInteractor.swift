//
//  ArtistScreenInteractor.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 12/11/24.
//

import UIKit

protocol ArtistScreenInteractorProtocol: AnyObject {
    func fetchDataAlbums(_ tag: Int)
    //func getInformationOut(_ tag: Int)
}

class ArtistScreenInteractor: ArtistScreenInteractorProtocol {
    weak var presenter: ArtistScreenDetailPresenterProtocol?
    
    var albums: [ArtistInfo] = []
    
    func fetchDataAlbums(_ tag: Int) {
        albums = [
            ArtistInfo(nameArtistScreen: "Nirvana", imageArtistScreen: "bandN",
                       infoArtist: """
                       Formación: 1987 en Aberdeen, Washington.
                       Integrantes:
                       - Kurt Cobain: Voz principal y guitarra (fundador, 1987-1994).
                       - Krist Novoselic: Bajo y coros (fundador, 1987-1994).
                       - Dave Grohl: Batería y coros (1990-1994).
                       Nota: Nirvana se disolvió en 1994 tras el fallecimiento de Cobain.
                       """,
                       imageAlbum: ["album1_N", "album2_N", "album3_N"], nameAlbum: ["Nevermind", "In Utero", "MTV Unplugged in New York"], idAlbum: [0,1,2]),
            ArtistInfo(nameArtistScreen: "Guns N' Roses", imageArtistScreen: "bandGNR",
                       infoArtist: """
                       Formación: 1985 en Los Ángeles, California.
                       Integrantes:
                       - Axl Rose: Voz principal y teclados (fundador).
                       - Slash: Guitarra principal (1985-1996).
                       - Duff McKagan: Bajo y coros (1985-1997).
                       - Richard Fortus: Guitarra rítmica (desde 2002).
                       - Dizzy Reed: Teclados, piano y coros (desde 1990).
                       - Frank Ferrer: Batería (desde 2006).
                       - Melissa Reese: Teclados y coros (desde 2016).
                       """,
                       imageAlbum: ["album1_GNR", "album2_GNR", "album3_GNR"], nameAlbum: ["Appetite for Destruction", "Use Your Illusion I", "Use Your Illusion II"], idAlbum: [0,1,2]),
            ArtistInfo(nameArtistScreen: "Iron Maiden", imageArtistScreen: "bandIM",
                       infoArtist: "Formación: 1975 en Londres, Inglaterra.\nIntegrantes:\nSteve Harris: Bajo, teclados y coros (fundador).\nBruce Dickinson: Voz principal (1981-1993).\nDave Murray: Guitarra (desde 1976).\nAdrian Smith: Guitarra y coros (1979-1990, regresó en 1999).\nJanick Gers: Guitarra (desde 1990).\nNicko McBrain: Batería (desde 1982)",
                       imageAlbum: ["album1_IM", "album2_IM", "album3_IM"], nameAlbum: ["The Number of the Beast", "Powerslave", "Somewhere in Time"], idAlbum: [0,1,2]),
            ArtistInfo(nameArtistScreen: "AC/DC", imageArtistScreen: "bandACDC",
                       infoArtist: """
                       Formación: 1973 en Sídney, Australia.
                       Integrantes Actuales:
                       - Angus Young: Guitarra principal (fundador, 1973).
                       - Brian Johnson: Voz principal (1980-2016).
                       - Cliff Williams: Bajo y coros (1977-2016).
                       - Phil Rudd: Batería (1975-1983, regresó en 1994 y 2020).
                       - Stevie Young: Guitarra rítmica (2014).
                       """,
                       imageAlbum: ["album1_ACDC", "album2_ACDC", "album3_ACDC"], nameAlbum: ["Back in Black", "Highway to Hell", "The Razors Edge"], idAlbum: [0,1,2]),
            ArtistInfo(nameArtistScreen: "Queen", imageArtistScreen: "bandQ",
                       infoArtist: """
                       Formación: 1970 en Londres, Inglaterra.
                       Integrantes Originales:
                       - Freddie Mercury: Voz principal y piano (1970-1991; falleció en 1991).
                       - Brian May: Guitarra y coros (fundador, desde 1970).
                       - Roger Taylor: Batería y coros (fundador, desde 1970).
                       - John Deacon: Bajo (1971-1997; se retiró oficialmente en 1997).
                       """,
                       imageAlbum: ["album1_Q", "album2_Q", "album3_Q"], nameAlbum: ["A Night at the Opera", "News of the World", "The Game"], idAlbum: [0,1,2])
            
        ]
        
        let artistInformation = albums[tag]
        
        presenter?.viewDidLoad(artistInformation)
        
        
    }
    
}
