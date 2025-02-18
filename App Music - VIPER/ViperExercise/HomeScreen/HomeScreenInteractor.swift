//
//  HomeScreenInteractor.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 10/11/24.
//

import UIKit

protocol ArtistDetailInteractorProtocol: AnyObject {
    func fetchDataArtist()
   // func getInformationOut(_ tag: Int)
}


class HomeScreenInteractor: ArtistDetailInteractorProtocol {
    weak var presenter: ArtistDetailPresenterProtocol?
    
    var artists: [Artist] = []
 
    func fetchDataArtist() {
        
        artists = [
            Artist(idArtist: 0, nameArtist: "Nirvana", imageArtist: "Nirvana"),
            Artist(idArtist: 1, nameArtist: "Guns N' Roses", imageArtist: "GunsNRoses"),
            Artist(idArtist: 2, nameArtist: "Iron Maiden", imageArtist: "Iron Maiden"),
            Artist(idArtist: 3, nameArtist: "AC/DC", imageArtist: "ACDC"),
            Artist(idArtist: 4, nameArtist: "Queen", imageArtist: "Queen")
        ]
        
        presenter?.didFetchDataArtist(artists)
    }
    
//    func getInformationOut(_ tag: Int) {
//        //print("Llegue al interactor")
//        let informationArtist = artists[tag].nameArtist
//        //print("La information es: \(informationArtist)")
//        presenter?.getInformationForView(informationArtist)
//    }
}



