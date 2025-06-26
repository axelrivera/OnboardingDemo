//
//  MainView.swift
//  OnboardingDemo
//
//  Created by Axel Rivera on 6/25/25.
//

import SwiftUI

struct MainView: View {
    @Binding var isOnboardingVisible: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                }
                
                Button("Show Onboarding", action: showOnboarding)
                    .padding(.vertical)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
            }
            .padding()
            .navigationTitle(Text("Onboarding Demo"))
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

extension MainView {

    func showOnboarding() {
        withAnimation {
            isOnboardingVisible.toggle()
        }
    }
    
}

#Preview {
    @Previewable @State var isOnboardingVisible = true
    
    MainView(isOnboardingVisible: $isOnboardingVisible)
}
