//
//  AuthViewModelServices.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import Foundation

protocol AuthViewModelServicesProtocol {
    
    var authService: AuthServiceProtocol { get }
    var sessionService: SessionServiceProtocol { get }
    
}

class AuthViewModelServices: BaseService, AuthViewModelServicesProtocol {
    
    var authService: AuthServiceProtocol
    var sessionService: SessionServiceProtocol
    
    init(authService: AuthServiceProtocol, sessionService: SessionServiceProtocol) {
        self.authService = authService
        self.sessionService = sessionService
    }
    
}
