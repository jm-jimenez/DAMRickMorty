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
        let navigationController = UINavigationController()
        let coordinator = Coordinator(navigationController: navigationController)
        coordinator.setupInitialViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

