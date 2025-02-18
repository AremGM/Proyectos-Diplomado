//
//  AlbumScreenRouter.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 13/11/24.
//

import UIKit

protocol AlbumScreenRouterProtocol: AnyObject {
    func navigationToSongScreen(tagSong: Int, tagArtist: Int, tagAlbum: Int)
}

class AlbumScreenRouter: AlbumScreenRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModuleAlbumScreen(_ tagAlbum: Int, _ tagArtist: Int) -> UIViewController {
        let view = AlbumScreenView()
        let presenter = AlbumScreenPresenter()
        let interactor = AlbumScreenInteractor()
        let router = AlbumScreenRouter()
        
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        presenter.idBArtist = tagArtist
        presenter.idBAlbum = tagAlbum
        presenter.infoAlbum(tagAlbum: tagAlbum, tagArtist: tagArtist)
        
        return view
    }
    
    func navigationToSongScreen(tagSong: Int, tagArtist: Int, tagAlbum: Int) {
        //print("Llegue al router")
        let songScreenSelected = SongScreenRouter.createModuleSongScreen(tagSong, tagArtist, tagAlbum)
        viewController?.navigationController?.pushViewController(songScreenSelected, animated: true)
    }
    
}
