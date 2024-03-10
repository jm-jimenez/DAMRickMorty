//
//  Coordinator.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 10/3/24.
//

import Foundation
import UIKit

struct Coordinator {
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setupInitialViewController() {
        let presenter = RickMortyListPresenter(coordinator: self)
        let vc = RickMortyListViewController(presenter: presenter)
        presenter.view = vc
        navigationController.viewControllers = [vc]
    }

    func goToDetailWith(character: Character) {
        let presenter = RickMortyDetailPresenter(character: character)
        let vc = RickMortyDetailViewController(presenter: presenter)
        presenter.view = vc
        navigationController.pushViewController(vc, animated: true)
    }
}
