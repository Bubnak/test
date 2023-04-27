//
//  FirstCoordinator.swift
//  Cord
//
//  Created by Kanan Abilzada on 02.07.21.
//

import UIKit

class ChildCoordinator: CoordinatorInterface {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func goToFirstView() {
        
        let firstViewController = ViewController(nibName: "ViewController", bundle: nil)
        firstViewController.initInterator(qInterator: InteractorFactory.create())
        firstViewController.coordinator = self
        navigationController.pushViewController(firstViewController, animated: true)
    }
    
    

}

