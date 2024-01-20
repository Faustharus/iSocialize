//
//  ForgotPasswordViewModel.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 20/01/2024.
//

import Combine
import Foundation

protocol ForgotPasswordViewModel {
    var email: String { get }
    var service: ForgotPasswordService { get }
    init(service: ForgotPasswordService)
    func sendPasswordReset()
}

final class ForgotPasswordViewModelImpl: ObservableObject, ForgotPasswordViewModel {
    
    @Published var email: String = ""
    let service: ForgotPasswordService
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: ForgotPasswordService) {
        self.service = service
    }
    
    func sendPasswordReset() {
        service
            .sendPasswordReset(to: email)
            .sink { res in
                switch res {
                case .failure(let err):
                    print("Failed: \(err.localizedDescription)")
                default: break
                }
            } receiveValue: {
                print("Password Reset Request Sent")
            }
            .store(in: &subscriptions)

    }
    
    
}
