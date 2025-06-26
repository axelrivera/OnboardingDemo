//
//  OnboardingView.swift
//  OnboardingDemo
//
//  Created by Axel Rivera on 6/25/25.
//

import SwiftUI
import CoreLocation

// DEMO NOTE: This enum defines the onboarding flow sequence
// Customize these pages based on your app's needs. Popular onboarding pages include:
//
// Permission Pages (ask when the feature provides clear value):
// - .notifications (push notification permissions)
// - .location (location services for maps, weather, nearby services)
// - .health (for fitness, health tracking apps)
//
// User Setup Pages:
// - .welcome (app introduction and value proposition)
// - .profile (name, avatar, basic info)
// - .preferences (display settings, content preferences)
// - .interests (content categories, topics of interest)
// - .goals (fitness goals, learning objectives, etc.)
// - .experience (skill level, usage patterns)
//
// Business/Monetization Pages:
// - .subscription (premium features, pricing plans)
// - .freeTrial (trial signup, feature preview)
// - .paywall (premium upgrade before core features)
//
// Completion Pages:
// - .tutorial (quick feature walkthrough)
// - .completion (success state, next steps)
//
// Best practices: Keep onboarding short (3-5 pages max), ask for permissions
// only when the benefit is clear, and always allow skipping non-essential steps

enum OnboardingPage: String, Identifiable, CaseIterable {
    case welcome
    case location
    case userInput
    
    var id: String { rawValue}
    
    static var first: Self = .welcome
}

struct OnboardingView: View {
    @Binding var isOnboardingVisible: Bool
    
    private let pages = OnboardingPage.allCases
    
    @State private var position: ScrollPosition = .init(idType: OnboardingPage.ID.self)
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(pages) { page in
                    switch page {
                    case .welcome:
                        WelcomePage(onComplete: welcomeComplete)
                    case .location:
                        LocationPage(onComplete: locationComplete)
                    case .userInput:
                        UserInputPage(onComplete: userInputComplete)
                    }
                }
                .containerRelativeFrame([.horizontal])
            }
            .scrollTargetLayout()
        }
        .scrollPosition($position)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .scrollDisabled(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .onAppear {
            position.scrollTo(id: OnboardingPage.first.id)
        }
    }
}

extension OnboardingView {
    
    func welcomeComplete() {
        scrollToPage(.location)
    }
    
    func locationComplete(isAuthorized: Bool) {
        // If user authorized location access, you can now fetch their current location
        // and process any relevant data for your app (weather, nearby services, etc.)
        // Example:
        // if isAuthorized {
        //     let locationManager = CLLocationManager()
        //     locationManager.requestLocation() // Get current location
        //     // Process location data for personalized content
        // }
        
        scrollToPage(.userInput)
    }
    
    func userInputComplete(temperatureUnit: UserInputPage.TemperatureUnit) {
        // Save the selected preferences to UserDefaults for persistent storage
        // These preferences should be accessible throughout the app and changeable in Settings
        // Example:
        // UserDefaults.standard.set(temperatureUnit.rawValue, forKey: "temperatureUnit")
        // UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        // 
        // For more complex preferences, consider using a PreferencesManager:
        // PreferencesManager.shared.temperatureUnit = temperatureUnit
        // PreferencesManager.shared.hasCompletedOnboarding = true
        
        withAnimation {
            isOnboardingVisible = false
        }
    }
    
    private func scrollToPage(_ page: OnboardingPage) {
        withAnimation {
            position.scrollTo(id: page.id)
        }
    }
    
}


#Preview {
    @Previewable @State var onboardingVisible = true
    
    OnboardingView(isOnboardingVisible: $onboardingVisible)
}
