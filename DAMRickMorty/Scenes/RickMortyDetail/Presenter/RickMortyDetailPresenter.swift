//
//  RickMortyDetailPresenter.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 10/3/24.
//

import Foundation

protocol RickMortyDetailPresenterProtocol {
    var view: RickMortyDetailViewProtocol? { get set }
    func viewDidLoad()
}

final class RickMortyDetailPresenter {
    weak var view: RickMortyDetailViewProtocol?

    private var character: Character

    init(character: Character) {
        self.character = character
    }
}

extension RickMortyDetailPresenter: RickMortyDetailPresenterProtocol {
    func viewDidLoad() {
        view?.setCharacterInfo(character)
    }
}
