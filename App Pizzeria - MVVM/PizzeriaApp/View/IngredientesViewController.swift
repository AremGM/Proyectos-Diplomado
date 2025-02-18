//
//  IngredientesViewController.swift
//  PizzeriaApp
//
//  Created by Emiliano Gil  on 26/01/25.
//

import UIKit

class IngredientesViewController: UIViewController {
    
    private let viewModel = IngredientesViewModel()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableingredients: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var buttonIngredients: UIButton = {
        let button = UIButton()
        button.setTitle("Add New Pizza", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self,
                         action: #selector(didTapButton),
                         for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ingredients"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        viewModel.delegate = self
        
        tableingredients.delegate = self
        tableingredients.dataSource = self
        tableingredients.register(UITableViewCell.self,
                                  forCellReuseIdentifier: viewModel.ingredientCellIdentifier)
        tableingredients.allowsMultipleSelection = true
        
        setUpView()
        
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "plus") // Ícono del sistema
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(addNewIngredient), for: .touchUpInside)
        
        let buttonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = buttonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updateIngredientsListTable()
        tableingredients.reloadData()
    }
    
    func setUpView() {
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        contentView.addSubview(tableingredients)
        NSLayoutConstraint.activate([
            tableingredients.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            tableingredients.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            tableingredients.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            //tableingredients.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100)

        ])
        
        contentView.addSubview(buttonIngredients)
        NSLayoutConstraint.activate([
            buttonIngredients.topAnchor.constraint(equalTo: tableingredients.bottomAnchor, constant: 30),
            buttonIngredients.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 126),
            buttonIngredients.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -126),
            buttonIngredients.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -115),
            buttonIngredients.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        
    }
    
    @objc
    func didTapButton() {
        let alertController = UIAlertController(title: "Add New Pizza",
                                                message: "Typing new name pizza",
                                                preferredStyle: .alert)
        // Agregar un TextField al UIAlertController
        alertController.addTextField { textField in
            textField.placeholder = "New Name Pizza"
        }
        
        let acceptAction = UIAlertAction(title: "Accept", style: .default) { [weak self] _ in
            guard let self = self else { return }
            guard let newNamePizza = alertController.textFields?.first?.text, !newNamePizza.isEmpty else {
                print("El nombre de la pizza está vacío.")
                return
            }
            
            //print("Nombre de la pizza ingresado: \(newNamePizza)")
            viewModel.newNamePizza = newNamePizza
            
            //print("Guardado en el ViewModel: \(viewModel.newNamePizza!)")
            viewModel.updateSelectedIngredients()
            buttonIngredients.isHidden = viewModel.hidenButton()

        }
        
        alertController.addAction(acceptAction)
        
        // Presentar la alerta
        present(alertController, animated: true)
    }
    
    @objc
    func addNewIngredient(){
        let addIngredientVC = AddIngredientViewController()
        navigationController?.pushViewController(addIngredientVC, animated: true)
    }
    
    
    
}

extension IngredientesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.ingredientsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.ingredientCellIdentifier, for: indexPath)
        
        var cellConfiguration = cell.defaultContentConfiguration()
        let ingredient = viewModel.ingredient(at: indexPath)
        
        cellConfiguration.text = ingredient
        
        cell.contentConfiguration = cellConfiguration
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.isSelected(ingredient: indexPath.row)
        buttonIngredients.isHidden = viewModel.hidenButton()
        print(viewModel.selectedIngredients)
        //print(tableingredients.cellForRow(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.isNotSelected(ingredient: indexPath.row)
        buttonIngredients.isHidden = viewModel.hidenButton()
        print(viewModel.selectedIngredients)
    }
    
}


extension IngredientesViewController: IngredientsListViewModelDelegate {
    func shouldReloadTableData() {
        tableingredients.reloadData()
    }
    
}
