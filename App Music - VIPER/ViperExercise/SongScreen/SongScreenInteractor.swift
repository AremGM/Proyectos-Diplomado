//
//  SongScreenInteractor.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 14/11/24.
//

import UIKit

protocol SongScreenInteractorProtocol: AnyObject {
    func fetchDataSongs(_ tagSong: Int, _ tagArtist: Int, _ tagAlbum: Int)
    
    // Funciones para los botones del reproductor
    func infoNetxSong()
    func infoBackSong()
    func actionPlayPause()
    
    func startSliderTimer(_ valueInitial: Float)
}

class SongScreenInteractor: SongScreenInteractorProtocol {
    
    weak var presenter: SongScreenPresenterProtocol?
    
    var infoReproduction: SongScreen!
    var tagSongActual: Int!
    var idAlbumSelected: Int!
    
    
    // Slider
    var timerIncrementDecrement: Timer?
    var value: Float!
    var valueFinal: Float!
    
    
    func fetchDataSongs(_ tagSong: Int, _ tagArtist: Int, _ tagAlbum: Int) {
        
        let songs: [SongScreen] = [
            SongScreen(
                nameSong: [
                    ["Smells Like Teen Spirit", "Come as You Are", "Lithium", "In Bloom"],
                    ["Heart-Shaped Box", "Rape Me", "Dumb", "All Apologies"],
                    ["About a Girl", "Come as You Are", "The Man Who Sold the World", "Where Did You Sleep Last Night"]
                    ],
                imageAlbum: ["album1_N", "album2_N", "album3_N"],
                timeSeconds: [
                    [301, 219, 257, 255],
                    [281, 169, 152, 230],
                    [218, 253, 260, 308]
                ],
                timeText: [
                    ["5:01", "3:39", "4:17", "4:15"],
                    ["4:41", "2:49", "2:32", "3:50"],
                    ["3:38", "4:13", "4:20", "5:08"]
                    ]),
            
            SongScreen(
                nameSong: [
                    ["Welcome to the Jungle", "Sweet Child o' Mine", "Paradise City", "Nightrain"],
                    ["November Rain", "Don't Cry", "Live and Let Die", "Right Next Door to Hell"],
                    ["Civil War", "You Could Be Mine", "Knockin' on Heaven's Door","Estranged"]
                    ],
                imageAlbum: ["album1_GNR", "album2_GNR", "album3_GNR"],
                timeSeconds: [
                    [272, 356, 406, 268],
                    [537, 284, 184, 183],
                    [462, 343, 336, 564]
                ],
                timeText: [
                    ["4:32", "5:56", "6:46", "4:28"],
                    ["8:57", "4:44", "3:04", "3:03"],
                    ["7:42", "5:43", "5:36", "9:24"]]),
            
            SongScreen(
                nameSong: [
                    ["The Number of the Beast", "Run to the Hills", "Hallowed Be Thy Name","22 Acacia Avenue"],
                    ["Aces High", "2 Minutes to Midnight", "Powerslave", "Rime of the Ancient Mariner"],
                    ["Caught Somewhere in Time", "Wasted Years", "Heaven Can Wait","Stranger in a Strange Land"]
                    ],
                imageAlbum: ["album1_IM", "album2_IM", "album3_IM"],
                timeSeconds: [
                    [290, 234, 430, 394],
                    [271, 360, 432, 819],
                    [446, 307, 444, 345]
                ],
                timeText: [
                    ["4:50", "3:54", "7:10", "6:34"],
                    ["4:31", "6:00", "7:12", "13:39"],
                    ["7:26", "5:07", "7:24", "5:45"]]),
            
            SongScreen(
                nameSong: [
                    ["Back in Black", "Hells Bells", "Shoot to Thrill", "You Shook Me All Night Long"],
                    ["Highway to Hell", "Girls Got Rhythm", "Touch Too Much", "If You Want Blood (You've Got It)"],
                    ["Thunderstruck", "Moneytalks", "Are You Ready", "Mistress for Christmas"]
                    ],
                imageAlbum: ["album1_ACDC", "album2_ACDC", "album3_ACDC"],
                timeSeconds: [
                    [255, 312, 317, 210],
                    [208, 204, 269, 276],
                    [292, 226, 250, 240]
                ],
                timeText: [
                    ["4:15", "5:12", "5:17", "3:30"],
                    ["3:28", "3:24", "4:29", "4:36"],
                    ["4:52", "3:46", "4:10", "4:00"]]),
            
            SongScreen(
                nameSong: [
                    ["Bohemian Rhapsody", "You're My Best Friend", "Love of My Life", "I'm in Love with My Car"],
                    ["We Will Rock You", "We Are the Champions", "Sheer Heart Attack", "Spread Your Wings"],
                    ["Another One Bites the Dust", "Crazy Little Thing Called Love", "Save Me", "Play the Game"]
                    ],
                imageAlbum: ["album1_Q", "album2_Q", "album3_Q"],
                timeSeconds: [
                    [355, 170, 218, 185],
                    [122, 179, 206, 272],
                    [216, 163, 229, 210]
                ],
                timeText: [
                    ["5:55", "2:50", "3:38", "3:05"],
                    ["2:02", "2:59", "3:26", "4:32"],
                    ["3:36", "2:43", "3:49", "3:30"]]),
        ]
        
        
        let selectedSong = songs[tagArtist]
        
        infoReproduction = selectedSong
        tagSongActual = tagSong
        idAlbumSelected = tagAlbum
        valueFinal = Float(infoReproduction.timeSeconds[idAlbumSelected][tagSongActual])
        presenter?.viewDidLoad(infoSongSelected: selectedSong, tagSong: tagSong, tagAlbum: tagAlbum)
        
    }
    
    func infoNetxSong() {
        
        //print("Hola soy Interactor")
        tagSongActual = (tagSongActual + 1) % infoReproduction.nameSong[idAlbumSelected].count
        //print("La siguente cancion seria: \(infoReproduction.nameSong[idAlbumSelected][tagSongActual])")
        
        let newNnameSong = infoReproduction.nameSong[idAlbumSelected][tagSongActual]
        let newTiemSong = infoReproduction.timeText[idAlbumSelected][tagSongActual]
        let newTieamSlider = infoReproduction.timeSeconds[idAlbumSelected][tagSongActual]
        value = 0
        valueFinal = Float(infoReproduction.timeSeconds[idAlbumSelected][tagSongActual])
        presenter?.updateInformation(newNnameSong, newTiemSong, newTieamSlider)
        
    }
    
    func infoBackSong() {
        let indexSong = infoReproduction.nameSong[idAlbumSelected].count
        tagSongActual = (tagSongActual - 1 + indexSong) % indexSong
        
        let newNnameSong = infoReproduction.nameSong[idAlbumSelected][tagSongActual]
        let newTimeSong = infoReproduction.timeText[idAlbumSelected][tagSongActual]
        let newTimeSlider = infoReproduction.timeSeconds[idAlbumSelected][tagSongActual]
        value = 0
        valueFinal = Float(infoReproduction.timeSeconds[idAlbumSelected][tagSongActual])
        presenter?.updateInformation(newNnameSong, newTimeSong, newTimeSlider)
    }
    
    
    
    func actionPlayPause() {
        timerIncrementDecrement?.invalidate()
        print(valueFinal!)
    }
    
    
    func startSliderTimer(_ valueInitial: Float) {
        value = valueInitial
    
        timerIncrementDecrement = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if value < valueFinal {
                value += 1
                valueFinal -= 1
                presenter?.updateSliderValue(value, valueFinal)
            } else {
                self.timerIncrementDecrement?.invalidate()
            }
        }
        
    }
    
    
    deinit {
        timerIncrementDecrement?.invalidate()
    }
    
}
