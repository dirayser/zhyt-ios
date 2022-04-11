//
//  AuthViewModelProtocol.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import FirebaseAuth
import Foundation

protocol AuthViewModelProtocol {
    
    var mapper: AuthViewModelMapperProtocol { get }
    func signInWithGoogle(credentials: AuthCredential)
    
}

class AuthViewModel: BaseViewModel, AuthViewModelProtocol, Routable {
    
    var router:  AuthRoutingProtocol? { return baseRouter }
    let mapper: AuthViewModelMapperProtocol
    let services: AuthViewModelServicesProtocol
    
    init(mapper: AuthViewModelMapperProtocol, services: AuthViewModelServicesProtocol) {
        self.services = services
        self.mapper = mapper
        super.init()
    }
    
    func signInWithGoogle(credentials: AuthCredential) {
        services.authService.signIn(with: credentials).asObservable()
            .subscribe(onNext: { [weak self] (auth, error) in
                guard error == nil else { return }
                guard let self = self, let user = auth?.user else { return }
                self.setupLoggedInUser(user: user)
            }).disposed(by: disposeBag)
    }
    
    private func setupLoggedInUser(user: FirebaseAuth.User?) {
        guard let user = user else { return }
        services.sessionService.setup(user: user)
        router?.routeToMain(animated: true)
    }
    
}

