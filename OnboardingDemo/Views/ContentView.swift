//
//  ContentView.swift
//  OnboardingDemo
//
//  Created by Axel Rivera on 6/25/25.
//

import SwiftUI

// DEMO NOTE: Using a simple @State/@Binding for onboarding visibility
// Persisting the onboarding state (whether user has completed it) is outside the scope of this demo
//
// Production Best Practices:
// 1. Use a shared Observable ViewModel to handle app-wide data and state:
//    @Observable class AppDataViewModel {
//        var hasCompletedOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
//        var userPreferences: UserPreferences = UserPreferences.loadFromDefaults()
//        var locationPermissionStatus: CLAuthorizationStatus = .notDetermined
//
//        var shouldShowOnboarding: Bool { !hasCompletedOnboarding }
//
//        func completeOnboarding(with preferences: UserPreferences) {
//            hasCompletedOnboarding = true
//            userPreferences = preferences
//            saveToUserDefaults()
//        }
//    }
//
// 2. Inject this ViewModel throughout your app for consistent state management
// 3. Handle onboarding completion alongside other app initialization logic
// 4. Consider versioning for major updates that require re-onboarding
// 5. Allow users to reset/replay onboarding from Settings if beneficial

struct ContentView: View {
    @State var isOnboardingVisible: Bool = false
    
    var body: some View {
        MainView(isOnboardingVisible: $isOnboardingVisible)
            .overlay {
                // Using .overlay is the best approach for onboarding screens because:
                // 1. Preserves the main app view hierarchy - no complex navigation logic needed
                // 2. Provides seamless animations when showing/hiding onboarding
                // 3. Maintains existing app state underneath - users don't lose their place
                // 4. Easy to dismiss with simple state changes and animations
                // 5. Works well with safe areas and device orientations
                // 6. Allows the onboarding to be a completely separate view hierarchy
                //
                // Alternative approaches and their drawbacks:
                // - NavigationStack push: Creates back button, feels like regular navigation
                // - Sheet presentation: Swipe-to-dismiss conflicts with onboarding flow control
                // - fullScreenCover: Good alternative, but less flexible for custom animations
                // - Conditional view replacement: Destroys and recreates main view unnecessarily
                
                if isOnboardingVisible {
                    OnboardingView(isOnboardingVisible: $isOnboardingVisible)
                }
            }
    }
}

extension ContentView {

    func showOnboarding() {
        isOnboardingVisible.toggle()
    }
    
}

#Preview {
    @Previewable @State var isOnboardingVisible = false
    
    ContentView(isOnboardingVisible: isOnboardingVisible)
}
