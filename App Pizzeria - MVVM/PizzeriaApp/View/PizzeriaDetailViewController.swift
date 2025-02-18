//
//  PizzeriaDetailViewController.swift
//  PizzeriaApp
//
//  Created by Emiliano Gil  on 27/01/25.
//

import UIKit
import Lottie

class PizzeriaDetailViewController: UIViewController {

    
    private let viewModel: PizzeriaDetailViewModel
    
    var animationView: LottieAnimationView!
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var confinguration = UIButton.Configuration.borderedProminent()
        confinguration.title = "Location"
        
        button.configuration = confinguration
        
        button.addTarget(self,
                         action: #selector(didTapLocationButton),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var labelAddress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.pizzeria.address
        label.numberOfLines = 3
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    

    init(pizzeria: PizzaData.Pizzerias){
        self.viewModel = PizzeriaDetailViewModel(pizzeria: pizzeria)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.title = viewModel.pizzeria.name
        
        animationView = LottieAnimationView(name: "pizzeriaLocation")
        animationView.contentMode = .scaleAspectFill
        //animationView.backgroundColor = .blue
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let contentViewHeighAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeighAnchor.isActive = true
        contentViewHeighAnchor.priority = UILayoutPriority.required - 1
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        contentView.addSubview(labelAddress)
        
        NSLayoutConstraint.activate([
            labelAddress.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            labelAddress.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelAddress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelAddress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        
        
        if let _ = viewModel.pizzeria.coordinates {
            contentView.addSubview(locationButton)
            NSLayoutConstraint.activate([
                locationButton.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 80),
                locationButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        }
        
        view.addSubview(animationView)
        
        animationView.play()
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            animationView.widthAnchor.constraint(equalToConstant: 350),
            animationView.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        
        
    }
    
    
    @objc
    func didTapLocationButton() {
        let locationVC = PizzeriaLocationViewController(pizzeria: viewModel.pizzeria,
                                                        pizzeriaImage: "flag.square.fill")
        present(locationVC, animated: true)
    }
    
}
