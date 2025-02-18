//
//  SongScreenRouter.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 14/11/24.
//

import UIKit

protocol SongScreenRouterProtocol: AnyObject {
    
}

class SongScreenRouter: SongScreenRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModuleSongScreen(_ tag: Int, _ tagArtist: Int, _ tagAlbum: Int) -> UIViewController{
        let view = SongScreenView()
        let presenter = SongScreenPresenter()
        let interactor = SongScreenInteractor()
        let router = SongScreenRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        presenter.infoSongSelected(tag, tagArtist, tagAlbum)
        
        return view
    }
    
}
