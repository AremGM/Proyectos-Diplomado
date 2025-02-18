//
//  ViewController.swift
//  proyectoFinalGitHub
//
//  Created by Diplomado on 11/01/25.
//

import UIKit


class GitUserViewController: UIViewController {

    //OUTLET
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var buttonGetFollowers: UIButton!
    
    var usernameController: String!

    @IBAction func buttonGetFollowers(_ sender: Any) {
        guard let username = textFieldUserName.text, !username.isEmpty else { return }
        
        fetchFollowers(for: username) { followers, error in
            DispatchQueue.main.async {
                self.usernameController = username
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                    
                } else if let followers = followers {
                    self.segueFollowersScreen(with: followers, username: username)
                    
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.title = "GitHub User"
        buttonGetFollowers.isHidden = true
        
        textFieldUserName.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }


    @objc func textFieldDidChange() {
        if let text = textFieldUserName.text, !text.isEmpty {
            buttonGetFollowers.isHidden = false
        } else {
            buttonGetFollowers.isHidden = true
        }
    }
    
    func fetchFollowers(for username: String, completion: @escaping ([User]?, Error?) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/followers") else {
            return
        }
        
        let taskerror = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let followers = try JSONDecoder().decode([User].self, from: data!)
                completion(followers, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
        
    }
    
    func segueFollowersScreen(with followers: [User], username: String) {
        let followersVC = storyboard?.instantiateViewController(withIdentifier: "FollowersViewController") as! FollowersViewController
        followersVC.followers = followers
        print(followers)
        
        followersVC.userFollow = usernameController
        
        // Obtener la URL del avatar del usuario buscado
        if let user = followers.first(where: { $0.login == username }) {
            followersVC.userAvatarURL = user.avatar_url
        } else {
            // Si no se encuentra, usa una URL predeterminada o deja vacío
            followersVC.userAvatarURL = ""
        }
        
        let backButton = UIBarButtonItem()
        backButton.title = "Search"
        navigationItem.backBarButtonItem = backButton
        
        navigationController?.pushViewController(followersVC, animated: true)
    }

}

