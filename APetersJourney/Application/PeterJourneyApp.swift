//
//  AppDelegate.swift
//  A Peter's Journey
//
//  Created by Robson Lima Lopes on 30/03/23.
//

import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                OnboardingView()
            }
            .navigationViewStyle(StackNavigationViewStyle())

        }
    }
}
