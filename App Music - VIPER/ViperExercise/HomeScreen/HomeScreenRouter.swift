//
//  HomeScreenRouter.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 10/11/24.
//

import UIKit

//protocol
protocol navigationRouterProtocol {
    func navigateToArtistScreen(with idButtonAlbum: Int)
}

class HomeScreenRouter: navigationRouterProtocol {

    weak var viewController: UIViewController?
    
    static func createModuleHomeScreen() -> UIViewController {
        let view = HomeScreenView()
        let presenter = HomeScreenPresenter()
        let interactor = HomeScreenInteractor()
        let router = HomeScreenRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToArtistScreen(with tagArtist: Int) {
        let artistScreen = ArtistScreenRouter.createModuleArtistScreen(idButtonAlbum: tagArtist)
        viewController?.navigationController?.pushViewController(artistScreen, animated: true)
    }
    
}
