//
//  BaseViewModel.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import Dip
import RxSwift

class BaseViewModel {
    
    let viewModelFactoryContainer = Injected<ViewModelFactoryProtocol>()
    var viewModelFactory: ViewModelFactoryProtocol? { return viewModelFactoryContainer.wrappedValue }
    private var routing = Injected<RoutingProtocol>()
    var baseRouter: RoutingProtocol? {
        return routing.wrappedValue
    }
    var disposeBag = DisposeBag()
    
    init() {}
    
}
