//
//  AppDelegate.swift
//  zhyt
//
//  Created by Dmitriy Dmitriyev on 11.04.2022.
//

import UIKit
import Dip
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let container = DependencyContainer()
    private var viewModel: StartUpViewModelProtocol?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ContainerConfigurator.configure(container)
        configureWindow()
        configureKeyboard()
        return true
    }

    private func configureWindow() {
        window = try? container.resolve()
        window?.makeKeyAndVisible()
        if let startUpWindow = window as? StartUpWindow {
            viewModel = startUpWindow.viewModel
            viewModel?.goToNext()
        }
    }
    
    private func configureKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }

}

