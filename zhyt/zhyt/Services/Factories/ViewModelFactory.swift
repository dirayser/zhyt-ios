//
//  ViewModelFactory.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import Dip

protocol ViewModelFactoryProtocol {
    
    func buildViewModel<T>() throws -> T
    func buildViewModel<T, U>(_ arg1: U) throws -> T
    func buildViewModel<T, U, F>(_ arg1: U, _ arg2: F) throws -> T
    func buildViewModel<T, U, F, G>(_ arg1: U, _ arg2: F, _ arg3: G) throws -> T
    func buildViewModel<T, U, F, G, Z>(_ arg1: U, _ arg2: F, _ arg3: G, _ arg4: Z) throws -> T
    
}

extension DependencyContainer: ViewModelFactoryProtocol {
    
    func buildViewModel<T>() throws -> T {
        return try resolve()
    }
    
    func buildViewModel<T, U>(_ arg1: U) throws -> T {
        return try resolve(arguments: arg1)
    }
    
    func buildViewModel<T, U, F>(_ arg1: U, _ arg2: F) throws -> T {
        return try resolve(arguments: arg1, arg2)
    }
    
    func buildViewModel<T, U, F, G>(_ arg1: U, _ arg2: F, _ arg3: G) throws -> T {
        return try resolve(arguments: arg1, arg2, arg3)
    }
    
    func buildViewModel<T, U, F, G, Z>(_ arg1: U, _ arg2: F, _ arg3: G, _ arg4: Z) throws -> T {
        return try resolve(arguments: arg1, arg2, arg3, arg4)
    }
    
}

