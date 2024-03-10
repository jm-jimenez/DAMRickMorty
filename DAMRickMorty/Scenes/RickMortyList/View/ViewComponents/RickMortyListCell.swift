//
//  RickMortyListCell.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 10/3/24.
//

import UIKit

final class RickMortyListCell: UITableViewCell {
    
    @IBOutlet private weak var characterImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    func setupCharacter(_ character: Character) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        statusLabel.text = character.status
        loadImageFrom(url: character.image)
    }
}

private extension RickMortyListCell {
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
