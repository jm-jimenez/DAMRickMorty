//
//  RickMortyDetailViewController.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 10/3/24.
//

import UIKit

protocol RickMortyDetailViewProtocol: AnyObject {
    func setCharacterInfo(_ character: Character)
    func updateEpisodes(_ episodes: [Episode])
}

final class RickMortyDetailViewController: UIViewController {

    @IBOutlet private weak var characterImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    private let presenter: RickMortyDetailPresenterProtocol
    private var sections: [DetailSections] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    init(presenter: RickMortyDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "RickMortyDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        presenter.viewDidLoad()
    }
}

extension RickMortyDetailViewController: RickMortyDetailViewProtocol {
    func setCharacterInfo(_ character: Character) {
        loadImageFrom(url: character.image)
        nameLabel.text = character.name
        let viewModels =
        [DetailItemViewModel(title: "Name", value: character.name),
         DetailItemViewModel(title: "Species", value: character.species),
         DetailItemViewModel(title: "Status", value: character.status),
         DetailItemViewModel(title: "Origin", value: character.origin.name),
         DetailItemViewModel(title: "Location", value: character.location.name)
        ]
        sections = [.detail(viewModels: viewModels)]
    }

    func updateEpisodes(_ episodes: [Episode]) {
        sections.append(.episodes(episodes: episodes))
    }
}

private extension RickMortyDetailViewController {
    func setupViews() {
        characterImage.layer.cornerRadius = characterImage.frame.width / 2
    }

    func setupTableView() {
        tableView.register(UINib(nibName: "DetailItemCell", bundle: nil), forCellReuseIdentifier: "DetailItemCellReuse")
        tableView.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "EpisodeCellReuse")
        tableView.delegate = self
        tableView.dataSource = self
    }

    func loadImageFrom(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared
            .dataTask(with: url) { data, _, _ in
                guard let data else { return }
                DispatchQueue.main.async {
                    self.characterImage.image = UIImage(data: data)
                }
            }
            .resume()
    }
}

extension RickMortyDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sections[indexPath.section].cell(for: tableView, at: indexPath)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
}
