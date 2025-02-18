//
//  AlbumScreenPresenter.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 13/11/24.
//

import UIKit

protocol AlbumScreenPresenterProtocol: AnyObject {
    func infoAlbum(tagAlbum: Int, tagArtist: Int)
    func viewDidLoad(infoSongs: AlbumInfo, tagAlbum: Int)
    
    func getToScreenSong(tagSong: Int)
}

class AlbumScreenPresenter: AlbumScreenPresenterProtocol {
    weak var view: AlbumScreenViewProtocol?
    var interactor: AlbumScreenInteractorProtocol?
    var router: AlbumScreenRouterProtocol?
    
    var idBArtist: Int!
    var idBAlbum: Int!
    
    func infoAlbum(tagAlbum: Int, tagArtist: Int) {
        interactor?.fetchDataSongs(tagAlbum, tagArtist)
    }
    
    func viewDidLoad(infoSongs: AlbumInfo, tagAlbum: Int) {
        view?.showInformationSongs(infoSongs, tagAlbum)
    }
    
    
    func getToScreenSong(tagSong: Int) {
        //print("Llegue al presenter")
        router?.navigationToSongScreen( tagSong: tagSong, tagArtist: idBArtist, tagAlbum: idBAlbum)
    }
    
}
