//
//  LocationPage.swift
//  OnboardingDemo
//
//  Created by Axel Rivera on 6/25/25.
//

import SwiftUI
import CoreLocation

struct LocationPage: View {
    var onComplete: ((_ isAuthorized: Bool) -> Void)?
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Location Icon
            Image(systemName: "location.circle.fill")
                .font(.system(size: 120))
                .foregroundColor(.green)
            
            VStack(spacing: 16) {
                Text("Enable Location")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("We use your location to provide personalized recommendations and improve your experience.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button(action: requestLocationPermissions) {
                    Text("Allow Location Access")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .controlSize(.large)
                
                Button(action: { onComplete?(false) }) {
                    Text("Skip for Now")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
        }
    }
}

extension LocationPage {
    
    func requestLocationPermissions() {
        // DEMO NOTE: Actual location authorization is outside the scope of this demo
        // 
        // In a real implementation, this function would:
        // 1. Create a CLLocationManager instance
        // 2. Set up a delegate to handle authorization responses
        // 3. Call requestWhenInUseAuthorization() or requestAlwaysAuthorization()
        // 4. Handle the delegate callback in locationManager(_:didChangeAuthorization:)
        // 5. Call onComplete with the actual authorization status
        //
        // Example implementation:
        // let locationManager = CLLocationManager()
        // locationManager.delegate = self
        // locationManager.requestWhenInUseAuthorization()
        // 
        // Then in the delegate method:
        // func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //     switch status {
        //     case .authorizedWhenInUse, .authorizedAlways:
        //         onComplete?(true)
        //     case .denied, .restricted:
        //         onComplete?(false)
        //     case .notDetermined:
        //         break // Wait for user decision
        //     }
        // }
        
        // For demo purposes, we simulate successful authorization
        onComplete?(true)
    }
    
}

#Preview {
    LocationPage()
}
