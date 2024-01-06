//
//  SignUpViewModel.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 05/01/2024.
//

import Combine
import Foundation

enum SignUpState {
    case successfull
    case failed(error: Error)
    case na
}

protocol SignUpViewModel {
    var userDetails: SignUpDetails { get }
    var state: SignUpState { get }
    var service: SignUpService { get }
    init(service: SignUpService)
    func register()
}

final class SignUpViewModelImpl: ObservableObject, SignUpViewModel {
    
    @Published var userDetails: SignUpDetails = .new
    @Published var state: SignUpState = .na
    
    private var subscriptions = Set<AnyCancellable>()
    
    let service: SignUpService
    
    init(service: SignUpService) {
        self.service = service
    }
    
    func register() {
        service
            .register(with: userDetails)
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
    
}
