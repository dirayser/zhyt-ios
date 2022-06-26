//
//  RoutingTargetProvider.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import UIKit
import AppRouter

protocol RoutingTargetProviderProtocol : AnyObject {
    
    var rootViewController: UIViewController? { get set }
    var topViewController : UIViewController? { get }
    
    func route<T: UIViewController>(to: T.Type) throws where T: NonReusableViewProtocol
    
}

extension RoutingTargetProviderProtocol {
    
    var top: () -> UIViewController? { return { [weak self] in return self?.topViewController } }
    var root: () -> UIViewController? { return { [weak self] in return self?.rootViewController } }
    
}

class RoutingTargetProvider : RoutingTargetProviderProtocol {
    
    weak private var window: UIWindow?
    
    var rootViewController: UIViewController? {
        get { return window?.rootViewController }
        set { window?.rootViewController = newValue }
    }
    
    var topViewController : UIViewController? { return AppRouter.topViewController(startingFrom: rootViewController) }
    
    let viewFactory = Injection<ViewFactoryProtocol>()
    let viewModelFactory = Injection<ViewModelFactoryProtocol>()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func route<T: UIViewController>(to: T.Type) throws where T: NonReusableViewProtocol {
        let view: T = try viewFactory.value.buildView()
        topViewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}


