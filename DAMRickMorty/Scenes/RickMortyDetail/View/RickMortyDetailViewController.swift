//
//  RickMortyDetailViewController.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 10/3/24.
//

import UIKit

protocol RickMortyDetailViewProtocol: AnyObject {
    func setCharacterInfo(_ character: Character)
}

final class RickMortyDetailViewController: UIViewController {

    @IBOutlet private weak var characterImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    private let presenter: RickMortyDetailPresenterProtocol

    init(presenter: RickMortyDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "RickMortyDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension RickMortyDetailViewController: RickMortyDetailViewProtocol {
    func setCharacterInfo(_ character: Character) {
        loadImageFrom(url: character.image)
        nameLabel.text = character.name
    }
}

private extension RickMortyDetailViewController {
    func setupViews() {
        characterImage.layer.cornerRadius = characterImage.frame.width / 2
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
