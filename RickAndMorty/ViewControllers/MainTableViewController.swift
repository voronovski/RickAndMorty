//
//  MainTableViewController.swift
//  RickAndMorty
//
//  Created by Aleksei Voronovskii on 1/30/23.
//

import UIKit

final class MainTableViewController: UITableViewController {

    //MARK: Private properties
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        fetchCharacters()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let character = characters[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = character.name
        content.secondaryText = """
            Gender: \(character.gender ?? ""),
            From: \(character.origin?.name ?? "")
            """
        
        NetworkManager.shared.fetchData(from: character.image ?? "") { result in
            switch result {
            case .success(let imageData):
                content.image = UIImage(data: imageData)
                content.imageProperties.cornerRadius = tableView.rowHeight / 2
                cell.contentConfiguration = content
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
}

//MARK: Networking
extension MainTableViewController {
    private func fetchCharacters() {
        NetworkManager.shared.fetchCharacters(from: Link.top25.rawValue) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
