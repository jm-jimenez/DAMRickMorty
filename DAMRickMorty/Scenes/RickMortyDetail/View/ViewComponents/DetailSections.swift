//
//  DetailSections.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 10/3/24.
//

import Foundation
import UIKit

enum DetailSections {
    case detail(viewModels: [DetailItemViewModel])
    case episodes(episodes: [Episode])

    var numberOfRows: Int {
        switch self {
        case .detail(let viewModels): return viewModels.count
        case .episodes(let episodes): return episodes.count
        }
    }

    var title: String {
        switch self {
        case .detail: return "Character's details"
        case .episodes: return "Appears in"
        }
    }

    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        switch self {
        case .detail(let viewModels):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailItemCellReuse", for: indexPath) as? DetailItemCell else { return UITableViewCell() }
            cell.setupViewModel(viewModels[indexPath.item])
            return cell
        case .episodes(let episodes):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCellReuse", for: indexPath) as? EpisodeCell else { return UITableViewCell() }
            cell.setupEpisode(episodes[indexPath.item])
            return cell
        }
    }
}
