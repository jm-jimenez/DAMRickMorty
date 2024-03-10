//
//  RickMortyListViewController.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 4/3/24.
//

import UIKit

protocol RickMortyListViewProtocol: AnyObject {
    func setCharacters(_ characters: [Character])
}

final class RickMortyListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var characters: [Character] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private var presenter: RickMortyListPresenterProtocol

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        presenter = RickMortyListPresenter()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.getCharacters()
    }
}

private extension RickMortyListViewController {
    func setupTableView() {
        tableView.register(UINib(nibName: "RickMortyListCell", bundle: nil), forCellReuseIdentifier: "RickMortyListReuse")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension RickMortyListViewController: RickMortyListViewProtocol {
    func setCharacters(_ characters: [Character]) {
        self.characters = characters
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presenter = RickMortyDetailPresenter(character: characters[indexPath.item])
        let vc = RickMortyDetailViewController(presenter: presenter)
        presenter.view = vc
        navigationController?.pushViewController(vc, animated: true)
    }
}
