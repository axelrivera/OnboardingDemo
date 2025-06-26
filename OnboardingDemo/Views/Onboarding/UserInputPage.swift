//
//  UserInputPage.swift
//  OnboardingDemo
//
//  Created by Axel Rivera on 6/25/25.
//

import SwiftUI

// DEMO NOTE: This page demonstrates collecting user preferences during onboarding
// Temperature unit is just one example - developers can customize this to capture
// any preferences that significantly impact the initial user experience, such as:
// - Investment risk tolerance (conservative, moderate, aggressive)
// - Workout intensity level (beginner, intermediate, advanced)
// - Content maturity rating (family-friendly, teen, mature)
// - Trading experience level (novice, experienced, professional)
// - Dietary restrictions (vegetarian, vegan, gluten-free, keto)
// - Gaming difficulty preference (casual, normal, hardcore)
// - Learning style (visual, auditory, hands-on)
// - Budget range for recommendations ($, $$, $$$)
// - Professional role (developer, designer, manager, student)
// - Notification frequency (minimal, balanced, everything)
//
// Important: Users should always be able to change these preferences later in Settings

struct UserInputPage: View {
    @State private var selectedTemperatureUnit: TemperatureUnit = .celsius
    
    var onComplete: ((_ unit: TemperatureUnit) -> Void)?
    
    // Example preference enum - replace with preferences relevant to your app
    enum TemperatureUnit: String, CaseIterable {
        case fahrenheit = "fahrenheit"
        case celsius = "celcius"
        
        
        var name: String {
            switch self {
            case .fahrenheit: "Fahrenheit"
            case .celsius: "Celsius"
            }
        }
        
        var symbol: String {
            switch self {
            case .fahrenheit: "°F"
            case .celsius: "°C"
            }
        }
        
        var nameAndSymbol: String { "\(name) (\(symbol))" }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Temperature Icon
            Image(systemName: "thermometer.variable.and.figure")
                .font(.system(size: 120))
                .foregroundColor(.orange)
            
            VStack(spacing: 15) {
                Text("Temperature Preference")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Choose your preferred temperature unit for a better experience.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            // Temperature Unit Selection
            VStack(spacing: 12) {
                ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedTemperatureUnit = unit
                        }
                    }) {
                        HStack {
                            Text(unit.nameAndSymbol)
                                .font(.headline)
                                .foregroundColor(selectedTemperatureUnit == unit ? .white : .primary)
                            
                            Spacer()
                            
                            if selectedTemperatureUnit == unit {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedTemperatureUnit == unit ? Color.orange : Color(.systemGray6))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedTemperatureUnit == unit ? Color.orange : Color.clear, lineWidth: 2)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            Spacer()
            
            VStack {
                Button(action: { onComplete?(selectedTemperatureUnit) }) {
                    Text("Finish Onboarding")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.orange)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    UserInputPage()
}
