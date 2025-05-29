//
//  WebViewInteractor.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.
//


// Este archivo define el interactor para el módulo WebView
// No contiene lógica de negocio

import Foundation

protocol WebViewInteractorProtocol: AnyObject {
}

class WebViewInteractor: WebViewInteractorProtocol {
    weak var presenter: WebViewPresenterProtocol?
}

