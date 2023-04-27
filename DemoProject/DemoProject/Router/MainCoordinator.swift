//
//  AppCoordinator.swift
//  Cord
//
//  Created by Kanan Abilzada on 02.07.21.
//

import UIKit

class MainCoordinator: CoordinatorInterface {
    var navigationController: UINavigationController
    let window: UIWindow
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window               = window
        self.navigationController = navigationController
    }
    
    func start() {
        let navigationController  = UINavigationController()
        window.rootViewController =  navigationController
        window.makeKeyAndVisible()
        let childCoordinator = ChildCoordinator(navigationController: navigationController)
        childCoordinator.goToFirstView()
    }
}


