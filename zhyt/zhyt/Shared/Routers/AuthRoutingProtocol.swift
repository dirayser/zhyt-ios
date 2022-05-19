//
//  AuthRoutingProtocol.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import UIKit

protocol AuthRoutingProtocol {
    
    func routeToAuthorization()
    func routeToMain(animated: Bool)
    
}

extension BaseRouting: AuthRoutingProtocol {
    
    func routeToAuthorization() {
        do {
            let viewModel: AuthViewModelProtocol = try viewModelsFactory.buildViewModel()
            let vc = try viewsFactory.buildView(viewModel) as AuthViewController
            let navigation = UINavigationController(rootViewController: vc)
            navigation.isNavigationBarHidden = true
            targetProvider.rootViewController = navigation
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func routeToMain(animated: Bool) {
        print("Route to Home")
    }
    
}
