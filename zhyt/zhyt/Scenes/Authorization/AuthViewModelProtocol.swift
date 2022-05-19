//
//  AuthViewModelProtocol.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import RxOptional
import RxRelay

import Foundation

protocol AuthViewModelProtocol {
    
    var mapper: AuthViewModelMapperProtocol { get }
    var isLoading: BehaviorRelay<Bool> { get }
    
    func signIn(with login: String, password: String)
    
}

class AuthViewModel: BaseViewModel, AuthViewModelProtocol, Routable {
    
    var router:  AuthRoutingProtocol? { return baseRouter }
    let mapper: AuthViewModelMapperProtocol
    let services: AuthViewModelServicesProtocol
    
    var authService: AuthServiceProtocol { services.authService }
    
    let isLoading: BehaviorRelay<Bool> = .init(value: false)
    
    init(mapper: AuthViewModelMapperProtocol, services: AuthViewModelServicesProtocol) {
        self.services = services
        self.mapper = mapper
        super.init()
    }
    
    func signIn(with login: String, password: String) {
        authService.signIn(with: login, password: password)
            .asObservable()
            .subscribe(onNext: { [weak self] user, error in
                if let _ = error {
                    // MARK: handle error
                } else {
                    self?.setupLoggedInUser(user: user)
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupLoggedInUser(user: User?) {
        guard let user = user else { return }
        services.sessionService.setup(user: user)
        router?.routeToMain(animated: true)
    }
    
}

