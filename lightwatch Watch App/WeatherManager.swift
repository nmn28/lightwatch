//
//  WeatherManager.swift
//  lightwatch Watch App
//
//  Created by Nicholas Nelson on 9/21/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

@available(iOS 16.0, *)
class WeatherManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let weatherService = WeatherService.shared
    var locationManager = CLLocationManager() // Make sure this is var, not let

    @Published var uvIndex: Double = 0.0

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() // Call startUpdatingLocation() on the locationManager instance
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        fetchUVIndex(for: location)
    }

    func fetchUVIndex(for location: CLLocation) {
        Task {
            do {
                let weather = try await weatherService.weather(for: location)
                DispatchQueue.main.async {
                    self.uvIndex = Double(weather.currentWeather.uvIndex.value) // Ensure this is Double
                }
            } catch {
                print("Error fetching UV index: \(error)")
            }
        }
    }
}
