//
//  StartupViewModelProtocol.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import FirebaseAuth
import Foundation
import AppRouter

protocol StartUpViewModelProtocol {
    
    func goToNext()
    
}

class StartUpViewModel: BaseViewModel, StartUpViewModelProtocol, Routable {
    
    var router: SessionRoutingProtocol? { baseRouter }
    let sessionService: SessionServiceProtocol
    
    init(sessionService: SessionServiceProtocol) {
        self.sessionService = sessionService
        super.init()
    }
    
    func goToNext() {
        router?.routeToAuth()
    }
    
}
