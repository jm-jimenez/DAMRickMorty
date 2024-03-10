//
//  DetailItemCell.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 10/3/24.
//

import UIKit

struct DetailItemViewModel {
    let title: String
    let value: String
}

final class DetailItemCell: UITableViewCell {
    
    @IBOutlet private weak var detailTitle: UILabel!
    @IBOutlet private weak var detailValue: UILabel!

    func setupViewModel(_ viewModel: DetailItemViewModel) {
        detailTitle.text = viewModel.title
        detailValue.text = viewModel.value
    }
}
