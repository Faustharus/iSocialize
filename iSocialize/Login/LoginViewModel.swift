//
//  LoginViewModel.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 06/01/2024.
//

import Combine
import Foundation

enum LoginState {
    case successfull
    case failed(error: Error)
    case na
}

protocol LoginViewModel {
    var state: LoginState { get }
    var credentials: LoginDetails { get }
    var hasError: Bool { get }
    var service: LoginService { get }
    init(service: LoginService)
    func login()
}

final class LoginViewModelImpl: ObservableObject, LoginViewModel {
    
    @Published var state: LoginState = .na
    @Published var credentials: LoginDetails = .new
    @Published var hasError: Bool = false
    @Published var isEmailFormatValid: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    let service: LoginService
    
    init(service: LoginService) {
        self.service = service
        setupErrorConnection()
    }
    
    func login() {
        service
            .login(with: credentials)
            .sink { [weak self] res in
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successfull
            }
            .store(in: &subscriptions)
    }
    
    func checkEmailFormat(newValue: String) -> Bool {
        let emailRegex = try! Regex("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z0-9]{2,64}")
        
        do {
            if newValue.contains(emailRegex) {
                print("Valid Email Format")
                return isEmailFormatValid == true
            }
        }
        print("Email Format Invalid")
        return isEmailFormatValid == false
    }

}

private extension LoginViewModelImpl {
    
    func setupErrorConnection() {
        $state
            .map { state -> Bool in
                switch state {
                case .successfull,
                        .na:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasError)
    }
    
}
