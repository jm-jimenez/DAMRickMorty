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
}

final class RickMortyListPresenter {
    weak var view: RickMortyListViewProtocol?
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
}
