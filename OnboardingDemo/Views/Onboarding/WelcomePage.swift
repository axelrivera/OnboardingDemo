//
//  WelcomePage.swift
//  OnboardingDemo
//
//  Created by Axel Rivera on 6/25/25.
//

import SwiftUI

struct WelcomePage: View {
    var onComplete: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // App Icon/Logo
            Image(systemName: "star.circle.fill")
                .font(.system(size: 120))
                .foregroundColor(.blue)
            
            VStack(spacing: 16) {
                Text("Welcome to MyApp")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Discover amazing features and personalize your experience with our intuitive app.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button(action: { onComplete?() }) {
                    Text("Get Started")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
        .padding()
    }
}

#Preview {
    WelcomePage()
}
