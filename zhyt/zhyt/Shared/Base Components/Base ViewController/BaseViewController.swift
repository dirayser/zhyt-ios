//
//  BaseViewController.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShowUpdateConstraint(keyboardRect: CGRect) {
    }
    
    func keyboardWillHideUpdateConstraint() {
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        self.view.setNeedsLayout()
        self.keyboardWillShowUpdateConstraint(keyboardRect: keyboardSize)
        self.view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: UIView.AnimationOptions(rawValue: curve),
                       animations: {
                        self.view.layoutIfNeeded()
                       })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        self.view.setNeedsLayout()
        self.keyboardWillHideUpdateConstraint()
        self.view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: UIView.AnimationOptions(rawValue: curve),
                       animations: {
                        self.view.layoutIfNeeded()
                       })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

