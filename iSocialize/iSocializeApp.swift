//
//  iSocializeApp.swift
//  iSocialize
//
//  Created by Damien Chailloleau on 01/01/2024.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct iSocializeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceImpl()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                switch sessionService.state {
                case .loggedIn:
                    MainView()
                        .environmentObject(sessionService)
                case .loggedOut:
                    ContentView()
                }
            }
        }
    }
}
