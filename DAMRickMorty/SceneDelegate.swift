//
//  SceneDelegate.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 4/3/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let vc = RickMortyListViewController(nibName: "RickMortyListViewController", bundle: nil)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

