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
        loadEpisodes()
    }
}

private extension RickMortyDetailPresenter {
    func loadEpisodes() {
        let episodesArray = character.episode.compactMap { (incoming: String) -> Int? in
            let split = incoming.split(separator: "/")
            guard let last = split.last else { return nil }
            return Int(String(last))
        }
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode/\(episodesArray)") else { return }
        URLSession.shared
            .dataTask(with: url) { data, _, _ in
                guard let data else { return }
                guard let result = try? JSONDecoder().decode([Episode].self, from: data) else { return }
                DispatchQueue.main.async {
                    self.view?.updateEpisodes(result)
                }
            }
            .resume()
    }
}
