//
//  ArtistScreenPresenter.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 12/11/24.
//

import UIKit

protocol ArtistScreenDetailPresenterProtocol: AnyObject {
    func viewDidLoad(_ artistInfo: ArtistInfo)
    func getInformationArtist(idButtonAlbum: Int)
    
    func getSongs(idButtonAlbum: Int)
}

class ArtistScreenPresenter: ArtistScreenDetailPresenterProtocol {
    weak var view: ArtistScreenViewProtocol?
    var interactor: ArtistScreenInteractorProtocol?
    var router: ArtistScreenRouterProtocol?
    
    var idButtonArtistSelected: Int! //Conserva el valor del tag del boton del artista seleccionado
    
    func getInformationArtist(idButtonAlbum: Int) {
        interactor?.fetchDataAlbums(idButtonAlbum)
        //print("Hola")
    }
    
    func viewDidLoad(_ artistInfo: ArtistInfo) {
        view?.showInformationArtist(artistInfo)
    }
    
    func getSongs(idButtonAlbum: Int) {
        //print("El valor sigue siendo: \(String(describing: idButtonArtistSelected))")
        router?.navigationToAlbumScreen(idButtonAlbum: idButtonAlbum, artistId: idButtonArtistSelected)
    }
    
    
}
