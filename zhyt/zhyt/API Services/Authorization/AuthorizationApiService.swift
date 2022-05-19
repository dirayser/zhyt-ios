//
//  AuthorizationApiService.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import Foundation
import RxSwift

protocol AuthServiceProtocol {
    
    func getAuthorizationStatus() -> Single<User?>
    func signIn(with login: String, password: String) -> Single<(User?, Error?)>
    func signOut()
    
}

class AuthService: AuthServiceProtocol {
    
    func getAuthorizationStatus() -> Single<User?> {
        return Single.create { event -> Disposable in
            event(.success(nil))
            return Disposables.create()
        }
    }
    
    func signIn(with login: String, password: String) -> Single<(User?, Error?)> {
        return Single.create { event -> Disposable in
            let user = User()
            event(.success((user, nil)))
            return Disposables.create()
        }
    }
    
    func signOut() {
       
    }
    
}

