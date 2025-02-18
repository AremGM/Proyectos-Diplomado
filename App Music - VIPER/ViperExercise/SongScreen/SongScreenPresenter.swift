//
//  SongScreenPresenter.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 14/11/24.
//

import UIKit

protocol SongScreenPresenterProtocol: AnyObject {
    func infoSongSelected (_ tagSong: Int, _ tagArtist: Int, _ tagAlbum: Int)
    func viewDidLoad(infoSongSelected: SongScreen, tagSong: Int, tagAlbum: Int)
    
    // Funciones botones de cancion
    func playPauseSong()
    func nextSongAlbum()
    func backSongAlbum()
    
    func updateInformation(_ newName: String, _ newTime: String, _ newTimeSlider: TimeInterval)
    
    func sliderMoved(_ valueInitial: Float)
    func updateSliderValue(_ valueInitial: Float, _ valueFinal: Float)
    
}

class SongScreenPresenter: SongScreenPresenterProtocol {

    
    weak var view: SongScreenViewProtocol?
    var interactor: SongScreenInteractorProtocol?
    var router: SongScreenRouterProtocol?
    
    
    func infoSongSelected (_ tagSong: Int, _ tagArtist: Int, _ tagAlbum: Int) {
        interactor?.fetchDataSongs(tagSong, tagArtist, tagAlbum )
    }
    
    func viewDidLoad(infoSongSelected: SongScreen, tagSong: Int, tagAlbum: Int) {
        view?.showSong(infoSongSelected, tagSong, tagAlbum)
    }
    
    
    
    func playPauseSong() {
        interactor?.actionPlayPause()
    }
    
    func nextSongAlbum() {
        interactor?.infoNetxSong()
    }
    
    func backSongAlbum() {
        interactor?.infoBackSong()
    }
    
    func updateInformation(_ newName: String, _ newTime: String, _ newTimeSlider: TimeInterval) {
        view?.updateSongInformation(newName, newTime, newTimeSlider)
    }
    
    
    
    
    func sliderMoved(_ valueInitial: Float) {
        interactor?.startSliderTimer(valueInitial)
    }
    
    func updateSliderValue(_ valueInitial: Float, _ valueFinal: Float) {
        view?.sliderIncrementDecrement(valueInitial, valueFinal)
    }
    
}
