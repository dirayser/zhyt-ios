//
//  SessionRoutingProtocol.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import UIKit

protocol SessionRoutingProtocol {
    
    func routeToAuth()
    func routeToMain()
    func routeBack()
    
    func present(vc: UIViewController)
    func presentActivity(_ vc: UIActivityViewController)
    
}

extension BaseRouting: SessionRoutingProtocol {
    
    func routeToAuth() {
        routeToAuthorization()
    }
    
    func routeToMain() {
        routeToAuthorization()
    }
    
}
