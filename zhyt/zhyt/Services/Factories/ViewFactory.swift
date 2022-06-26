//
//  ViewFactory.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import Dip

protocol ViewFactoryProtocol {
    
    func buildView<T>() throws -> T
    func buildView<T, U>(_ arguments: U) throws -> T
    
}

extension DependencyContainer: ViewFactoryProtocol {

    func buildView<T>() throws -> T {
        return try resolve()
    }
    
    func buildView<T, U>(_ arguments: U) throws -> T {
        return try resolve(arguments: arguments)
    }
    
}
