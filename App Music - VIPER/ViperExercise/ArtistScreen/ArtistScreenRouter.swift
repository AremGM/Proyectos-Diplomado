//
//  ArtistScreenRouter.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 12/11/24.
//
import UIKit


protocol ArtistScreenRouterProtocol: AnyObject {
    func navigationToAlbumScreen(idButtonAlbum: Int, artistId: Int)
}


class ArtistScreenRouter: ArtistScreenRouterProtocol{
    weak var viewController: UIViewController?
    
    static func createModuleArtistScreen(idButtonAlbum: Int) -> UIViewController {
        let view = ArtistScreenView()
        let presenter = ArtistScreenPresenter()
        let interactor = ArtistScreenInteractor()
        let router = ArtistScreenRouter()
                
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
                
        // Pasar el userId al presenter para que lo use en el segundo módulo
        presenter.idButtonArtistSelected = idButtonAlbum
        presenter.getInformationArtist(idButtonAlbum: idButtonAlbum)
        
                
        return view
    }
    
    func navigationToAlbumScreen(idButtonAlbum: Int, artistId: Int) {
        let albumScreen = AlbumScreenRouter.createModuleAlbumScreen(idButtonAlbum, artistId)
        viewController?.navigationController?.pushViewController(albumScreen, animated: true)
    }
    
}
