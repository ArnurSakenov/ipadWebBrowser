//
//  SceneDelegate.swift
//  ipadWebBrowser
//
//  Created by Arnur Sakenov on 30.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let listViewController = HomeViewController()
        let leftNavController = UINavigationController(rootViewController: listViewController)

        let webViewController = WebViewController(delegate: listViewController)
        
        let rightNavController = UINavigationController(rootViewController: webViewController)

        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [leftNavController, rightNavController]
        splitViewController.preferredDisplayMode = .oneBesideSecondary

        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
    }

}

