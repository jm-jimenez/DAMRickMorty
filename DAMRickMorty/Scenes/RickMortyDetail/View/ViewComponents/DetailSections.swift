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
    case episodes

    var numberOfRows: Int {
        switch self {
        case .detail(let viewModels): return viewModels.count
        case .episodes: return 0
        }
    }

    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        switch self {
        case .detail(let viewModels):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailItemCellReuse", for: indexPath) as? DetailItemCell else { return UITableViewCell() }
            cell.setupViewModel(viewModels[indexPath.item])
            return cell
        case .episodes: return UITableViewCell()
        }
    }
}
