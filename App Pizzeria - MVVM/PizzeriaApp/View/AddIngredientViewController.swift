//
//  AddIngredientViewController.swift
//  PizzeriaApp
//
//  Created by Emiliano Gil  on 29/01/25.
//

import UIKit
import Lottie

class AddIngredientViewController: UIViewController {
    
    //Inicializacion directa () ya que no requiere de datos init
    private var viewModel = AddIngredientViewModel()
    
    var animationView: LottieAnimationView!
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Name of ingredient"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var buttonAdd: UIButton = {
        let button = UIButton()
        button.setTitle("Add Ingredient", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(saveNewIngredient), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    func setupUI() {
        
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ])
        
        view.addSubview(buttonAdd)
        
        NSLayoutConstraint.activate([
            buttonAdd.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            buttonAdd.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 95),
            buttonAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -95)
            
        ])
        
        animationView = LottieAnimationView(name: "ingredientsAnim")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        animationView.play()
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            animationView.widthAnchor.constraint(equalToConstant: 250),
            animationView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
    }
    

    @objc
    func saveNewIngredient() {
        guard let text = textField.text, !text.isEmpty else { return }
        viewModel.newIngredients.append(text)
        viewModel.saveNewIngredients()
        let data = viewModel.loadNewIngredientsData()
        print(data)
        //print(viewModel.newIngredients)
        navigationController?.popViewController(animated: true)
    }
   

}
