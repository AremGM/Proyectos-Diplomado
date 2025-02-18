//
//  HomeScreenPresenter.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 10/11/24.
//

import UIKit


protocol ArtistDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didFetchDataArtist(_ artists: [Artist])
    func getAlbums(tagArtist: Int)
    //func getInformationForView(_ information: String)
}


class HomeScreenPresenter: ArtistDetailPresenterProtocol {
    
    weak var view: ArtistDetailViewProtocol?
    var interactor: ArtistDetailInteractorProtocol?
    var router: navigationRouterProtocol?
    
    
    func viewDidLoad() {
        interactor?.fetchDataArtist()
    }
    
    func didFetchDataArtist(_ artists: [Artist]) {
        view?.showArtistDescription(artists)
    }
    
    func getAlbums(tagArtist: Int) {
        //print("Llegue al presenter al apretar el boton \(tag)")
        router?.navigateToArtistScreen(with: tagArtist)
        //interactor?.getInformationOut(tag)
        
    }
    
//    func getInformationForView(_ information: String) {
//        //print("Volvi al presenter")
//        //print("La informacion sigue siendo: \(information)")
//        view?.showInformation(information)
//        
//    }
    
}



