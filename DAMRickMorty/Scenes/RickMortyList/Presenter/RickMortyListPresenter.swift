//
//  RickMortyListPresenter.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 10/3/24.
//

import Foundation

protocol RickMortyListPresenterProtocol {
    var view: RickMortyListViewProtocol? { get set }
    func getCharacters()
    func didSelectCharacter(_ character: Character)
}

final class RickMortyListPresenter {
    weak var view: RickMortyListViewProtocol?
    private var coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}

extension RickMortyListPresenter: RickMortyListPresenterProtocol {
    func getCharacters() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        URLSession.shared
            .dataTask(with: url) { data, _, _ in
                guard let data else { return }
                guard let result = try? JSONDecoder().decode(GetCharactersReponse.self, from: data) else { return }
                DispatchQueue.main.async {
                    self.view?.setCharacters(result.results)
                }
            }
            .resume()
    }

    func didSelectCharacter(_ character: Character) {
        coordinator.goToDetailWith(character: character)
    }
}
