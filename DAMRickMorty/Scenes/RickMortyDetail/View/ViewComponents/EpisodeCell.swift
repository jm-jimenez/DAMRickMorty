//
//  EpisodeCell.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 10/3/24.
//

import UIKit

final class EpisodeCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var airDateLabel: UILabel!
    @IBOutlet private weak var episodeLabel: UILabel!

    func setupEpisode(_ episode: Episode) {
        titleLabel.text = episode.name
        airDateLabel.text = episode.airDate
        episodeLabel.text = episode.episode
    }
}
