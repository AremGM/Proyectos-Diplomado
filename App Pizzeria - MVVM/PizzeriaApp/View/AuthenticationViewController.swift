//
//  AuthenticationViewController.swift
//  PizzeriaApp
//
//  Created by Emiliano Gil  on 29/01/25.
//

import UIKit
import LocalAuthentication

class AuthenticationViewController: UIViewController {
    
    
    private lazy var imageLock: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock.iphone")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        isModalInPresentation = true
        
        view.backgroundColor = .black
        
        
        
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "Authenticate"
        
        let authenticationButton = UIButton(configuration: configuration)
        authenticationButton.translatesAutoresizingMaskIntoConstraints = false
        
        authenticationButton.addTarget(self,
                                       action: #selector(didTapAuthenticateButton),
                                       for: .touchUpInside)
        
        view.addSubview(imageLock)
        
        NSLayoutConstraint.activate([
            imageLock.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLock.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageLock.widthAnchor.constraint(equalToConstant: 300),
            imageLock.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        
        view.addSubview(authenticationButton)
        
        NSLayoutConstraint.activate([
            authenticationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authenticationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc
    func didTapAuthenticateButton() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Identify yourself"
            
            context.evaluatePolicy(.deviceOwnerAuthentication,
                                   localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
    

}
