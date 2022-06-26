//
//  NonReusableViewProtocol.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import RxSwift

private class AssociatedObjectWrapper<T> : NSObject {
    
    let object: T
    
    init(object: T) {
        self.object = object
    }
    
}

protocol NonReusableViewProtocol: AnyObject {
    
    associatedtype ViewModelProtocol
    var viewModel: ViewModelProtocol? { get set }
    var viewModelDisposeBag : DisposeBag { get }
    
    func didSetViewModel(_ viewModel: ViewModelProtocol)
    
}

protocol ReusableViewProtocol: NonReusableViewProtocol {
    
    func prepareForReuse()
    
}

private enum AssociatedKeys {
    
    static var disposeBag = "viewModel dispose bag associated key"
    static var viewModel = "view model associated key"
    
}

extension NonReusableViewProtocol where Self: NSObject {
    
    fileprivate(set) var viewModelDisposeBag: DisposeBag {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.disposeBag, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            if let bag = objc_getAssociatedObject(self, &AssociatedKeys.disposeBag) as? DisposeBag {
                return bag
            } else {
                let bag = DisposeBag()
                objc_setAssociatedObject(self, &AssociatedKeys.disposeBag, bag, .OBJC_ASSOCIATION_RETAIN)
                return bag
            }
        }
        
    }
    
    var viewModel: ViewModelProtocol? {
        
        set {
            guard objc_getAssociatedObject(self, &AssociatedKeys.viewModel) as? AssociatedObjectWrapper<ViewModelProtocol> == nil else {
                assertionFailure("\(type(of: self))")
                return
            }
            guard let newVM = newValue else {
                return
            }
            (self as? UIViewController)?.loadViewIfNeeded()
            (self as? UIViewController)?.view.layoutIfNeeded()
            (self as? UIView)?.layoutIfNeeded()
            objc_setAssociatedObject(self, &AssociatedKeys.viewModel, AssociatedObjectWrapper(object: newVM), .OBJC_ASSOCIATION_RETAIN)
            viewModelDisposeBag = DisposeBag()
            didSetViewModel(newVM)
        }
        
        get {
            guard let wrapper = objc_getAssociatedObject(self, &AssociatedKeys.viewModel) as? AssociatedObjectWrapper<ViewModelProtocol> else {
                return nil
            }
            return wrapper.object
        }
    }
    
}

extension ReusableViewProtocol where Self: NSObject {
    
    var viewModel: ViewModelProtocol? {
        set {
            (self as? UIViewController)?.loadViewIfNeeded()
            (self as? UIViewController)?.view.layoutIfNeeded()
            (self as? UIView)?.layoutIfNeeded()
            prepareForReuse()
            viewModelDisposeBag = DisposeBag()
            objc_setAssociatedObject(self, &AssociatedKeys.viewModel, AssociatedObjectWrapper(object: newValue), .OBJC_ASSOCIATION_RETAIN)
            guard let newVM = newValue else { return }
            (self as? UIView)?.layoutIfNeeded()
            didSetViewModel(newVM)
        }
        
        get {
            guard let wrapper = objc_getAssociatedObject(self, &AssociatedKeys.viewModel) as? AssociatedObjectWrapper<ViewModelProtocol?> else {
                return nil
            }
            return wrapper.object
        }
    }
    
}



