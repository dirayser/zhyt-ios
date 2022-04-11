//
//  AuthorizationApiService.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import Foundation
import RxSwift
import FirebaseAuth

protocol AuthServiceProtocol {
    
    var currentUser: FirebaseAuth.User? { get }
    func getAuthorizationStatus() -> Single<(Auth, FirebaseAuth.User?)>
    func signIn(with googleCredentials: AuthCredential) -> Single<(AuthDataResult?, Error?)>
    func signOut()
    
}

class AuthService: AuthServiceProtocol {
    
    var currentUser: FirebaseAuth.User? { Auth.auth().currentUser }
    
    func getAuthorizationStatus() -> Single<(Auth, FirebaseAuth.User?)> {
        return Single.create { event -> Disposable in
            Auth.auth().addStateDidChangeListener { (auth, user) in
                event(.success((auth, user)))
            }
            return Disposables.create()
        }
    }
    
    func signIn(with credentials: AuthCredential) -> Single<(AuthDataResult?, Error?)> {
        return Single.create { event -> Disposable in
            Auth.auth().signIn(with: credentials) { authResult, error in
                event(.success((authResult, error)))
            }
            return Disposables.create()
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
    }
    
}

