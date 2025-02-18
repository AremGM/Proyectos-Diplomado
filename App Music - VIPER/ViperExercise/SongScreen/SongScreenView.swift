//
//  SongScreenView.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 14/11/24.
//

import UIKit

protocol SongScreenViewProtocol: AnyObject {
    func showSong(_ infoSong: SongScreen, _ tagSong: Int, _ tagAlbum: Int)
    func updateSongInformation(_ newNameSomg: String, _ newTimeSong: String, _ newTimeSlider: TimeInterval)
    
    func sliderMove()
    func sliderIncrementDecrement(_ valueInitial: Float, _ valueFinal: Float)
}


class SongScreenView: UIViewController, SongScreenViewProtocol {
    
    lazy var imageMusic: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 420).isActive = true
        return imageView
    }()
    
    lazy var labelNameSong: UILabel = {
        let labelNSong = UILabel()
        labelNSong.textAlignment = .center
        labelNSong.font = .systemFont(ofSize: 26)
        labelNSong.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return labelNSong
    }()
    
    lazy var labeltimeMusic: UILabel = {
        let labelTMusic = UILabel()
        return labelTMusic
    }()
    
    lazy var labeltimeMusicFinal: UILabel = {
        let labelTMFinal = UILabel()
        return labelTMFinal
    }()
    
    lazy var sliderTime: UISlider = {
        let sliderT = UISlider()
        sliderT.minimumTrackTintColor = .black
        sliderT.value = 0
        return sliderT
    }()
    
    lazy var buttonBefore: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.tintColor = .black
        button.addAction(UIAction(handler: touchBack(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonPausePlay: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .black
        button.addAction(UIAction(handler: touchPausePlay(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonNext: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.tintColor = .black
        button.addAction(UIAction(handler: touchNext(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    var presenter: SongScreenPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        sliderMove()
    
    }

    func setMainStack(infoSong: SongScreen, tagSong: Int, tagAlbum: Int) {
        
        view.addSubview(mainStackView)
        
        // Agregar los stacks al stack principal
        
        let nameSongTapped = infoSong.nameSong[tagAlbum][tagSong]
        let imageAlbumTapped = infoSong.imageAlbum[tagAlbum]
        mainStackView.addArrangedSubview(createStackNameAlbumImage(nameSong: nameSongTapped, image: imageAlbumTapped))
        
        
        let timesSongs = infoSong.timeText[tagAlbum]
        mainStackView.addArrangedSubview(createStackVertical(timesSongs, tagSong, infoSong.timeSeconds[tagAlbum][tagSong]))

        // Establecer restricciones del stack principal
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -180)
        ])
    }

    
    
    private func createStackNameAlbumImage(nameSong: String, image: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 2
        
        // Añadir la imagen y stack de labels
        imageMusic.image = UIImage(named: image)
        stack.addArrangedSubview(labelsInformation(nameSong: nameSong))
        stack.addArrangedSubview(imageMusic)
        
        return stack
    }
    
    
    private func labelsInformation(nameSong: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        labelNameSong.text = nameSong
        stack.addArrangedSubview(labelNameSong)
        
        
        return stack
    }
    
    
    private func createStackVertical(_ timeSong: [String], _ tagSong: Int, _ valorInicial: TimeInterval) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
       
        // Añadir la imagen y el label al stack horizontal
        stack.addArrangedSubview(createStackButtons())
        sliderTime.maximumValue = Float(valorInicial)
        stack.addArrangedSubview(sliderTime)
        
        let timeSongTapped = timeSong[tagSong]
        stack.addArrangedSubview(createStackButtonsLabelTimes(timeSongTapped))
        
        return stack
    }
    
    
    private func createStackButtonsLabelTimes(_ timeSong: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
    
        // Añadir la imagen y el label al stack horizontal
        labeltimeMusic.text = "0:00"
        labeltimeMusicFinal.text = timeSong
        stack.addArrangedSubview(labeltimeMusic)
        stack.addArrangedSubview(labeltimeMusicFinal)
        
        return stack
    }
    
    private func createStackButtons() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
      
        // Añadir la imagen y el label al stack horizontal
        stack.addArrangedSubview(buttonBefore)
        stack.addArrangedSubview(buttonPausePlay)
        stack.addArrangedSubview(buttonNext)
        
        return stack
    }

    func showSong(_ infoSong: SongScreen, _ tagSong: Int, _ tagAlbum: Int) {
        setMainStack(infoSong: infoSong, tagSong: tagSong, tagAlbum: tagAlbum)
    }
    
    func updateSongInformation(_ newNameSong: String, _ newTimeSong: String, _ newTimeSlider: TimeInterval){
        labelNameSong.text = newNameSong
        labeltimeMusicFinal.text = newTimeSong
        sliderTime.value = 0
        sliderTime.maximumValue = Float(newTimeSlider)
    }
    
    
    private func touchBack(_ action: UIAction) {
        labeltimeMusic.text = "0:00"
        presenter?.backSongAlbum()
    }
    
    private func touchPausePlay(_ action: UIAction) {
        if buttonPausePlay.isSelected {
            buttonPausePlay.isSelected = false
            buttonPausePlay.setImage(UIImage(systemName: "play.circle"), for: .normal)
            sliderMove()
        } else {
            buttonPausePlay.isSelected = true
            buttonPausePlay.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            print("Se detiene")
            presenter?.playPauseSong()
        }
        
    }
    
    private func touchNext(_ action: UIAction) {
        labeltimeMusic.text = "0:00"
        presenter?.nextSongAlbum()
    }
    
    
    func sliderMove(){
        presenter?.sliderMoved(sliderTime.value)
        //print(sliderTime.maximumValue)
    }
    
    func sliderIncrementDecrement(_ valueInitial: Float, _ valueFinal: Float){
        sliderTime.value = valueInitial
        updateLabelWithSliderValue(valueFinal)
    }
    
    
    func updateLabelWithSliderValue(_ valueFinal: Float) {
        let totalSeconds = Int(sliderTime.value)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        labeltimeMusic.text = String(format: "%d:%02d", minutes, seconds)
        
        let totalSeconds2 = Int(valueFinal)
        let minutes2 = totalSeconds2 / 60
        let seconds2 = totalSeconds2 % 60
        labeltimeMusicFinal.text = String(format: "%d:%02d", minutes2, seconds2)
    }
    
    
}
