//
//  IngredientesListTableViewController.swift
//  PizzeriaApp
//
//  Created by Emiliano Gil  on 26/01/25.
//

import UIKit

class IngredientesListTableViewController: UITableViewController {

    
    private let viewModel = IngredientesViewModel()
    
    private lazy var buttonIngredients: UIButton = {
        let button = UIButton()
        button.setTitle("Add New Pizza", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textFieldNameNewPizza: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ingrese el nombre de la pizza"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var footerView: UIView = {
        let footerView = UIView()
        footerView.backgroundColor = .red
        footerView.translatesAutoresizingMaskIntoConstraints = false
        return footerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Ingredients"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self,
                                  forCellReuseIdentifier: viewModel.ingredientCellIdentifier)
        
        setUpFooterView()
    
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.ingredientsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.ingredientCellIdentifier, for: indexPath)
        
        var cellConfiguration = cell.defaultContentConfiguration()
        let ingredient = viewModel.ingredient(at: indexPath)
        
        cellConfiguration.text = ingredient
        
        cell.contentConfiguration = cellConfiguration
        
        return cell
    }

    
    private func setUpFooterView() {
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 220)
        tableView.tableFooterView = footerView
        footerView.addSubview(buttonIngredients)
        footerView.addSubview(textFieldNameNewPizza)
        
        NSLayoutConstraint.activate([
            buttonIngredients.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10),
            buttonIngredients.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            buttonIngredients.widthAnchor.constraint(equalTo: footerView.widthAnchor, multiplier: 0.5),
            buttonIngredients.heightAnchor.constraint(equalToConstant: 35),

            textFieldNameNewPizza.topAnchor.constraint(equalTo: buttonIngredients.bottomAnchor, constant: 10),
            textFieldNameNewPizza.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 10),
            textFieldNameNewPizza.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -10),
            textFieldNameNewPizza.heightAnchor.constraint(equalToConstant: 40),
            textFieldNameNewPizza.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -10)
        ])
        
        
        
    }


}
