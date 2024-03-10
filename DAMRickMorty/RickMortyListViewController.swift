//
//  RickMortyListViewController.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 4/3/24.
//

import UIKit

final class RickMortyListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var characters: [Character] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getCharacters()
    }
}

private extension RickMortyListViewController {
    func setupTableView() {
        tableView.register(UINib(nibName: "RickMortyListCell", bundle: nil), forCellReuseIdentifier: "RickMortyListReuse")
        tableView.delegate = self
        tableView.dataSource = self
    }

    func getCharacters() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        URLSession.shared
            .dataTask(with: url) { data, _, _ in
                guard let data else { return }
                guard let result = try? JSONDecoder().decode(GetCharactersReponse.self, from: data) else { return }
                DispatchQueue.main.async {
                    self.characters = result.results
                }
            }
            .resume()
    }
}

extension RickMortyListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RickMortyListReuse", for: indexPath) as? RickMortyListCell else { return UITableViewCell() }
        cell.setupCharacter(characters[indexPath.item])
        return cell
    }
}
