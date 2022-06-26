//
//  SessionServiceProtocol.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import FirebaseAuth
import Dip
import RxRelay

protocol SessionServiceProtocol {
    
    var user: BehaviorRelay<FirebaseAuth.User?> { get }
    func setup(user: FirebaseAuth.User)
    func logout()
    
}

class SessionService: BaseService, SessionServiceProtocol {
    
    let user: BehaviorRelay<FirebaseAuth.User?> = .init(value: nil)
    let authService: Injected<AuthServiceProtocol> = .init()
    
    override init() {
        super.init()
    }
    
    func setup(user: FirebaseAuth.User) {
        self.user.accept(user)
    }
    
    func logout() {
        user.accept(nil)
        authService.wrappedValue?.signOut()
    }
    
}
