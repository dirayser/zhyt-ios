//
//  AuthViewController.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import UIKit
import RxRelay

class AuthViewController: BaseViewController, NonReusableViewProtocol {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signInButton: UIButton!
    
    func didSetViewModel(_ viewModel: AuthViewModelProtocol) {
        setupUI()
        
        signInButton.addTarget(self, action: #selector(onSignIn), for: .touchUpInside)
    }
    
    private func setupUI() {
        signInButton.layer.cornerRadius = 15
        signInButton.clipsToBounds = true
        
        viewModel?.isLoading.map { !$0 }.bind(to: signInButton.rx.isEnabled).disposed(by: viewModelDisposeBag)
    }
    
    @objc private func onSignIn() {
        guard let email = emailTextField.text, let pswd = passwordTextField.text else { return }
        
        viewModel?.signIn(with: email, password: pswd)
    }
    
}

