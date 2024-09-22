//
//  HealthManager.swift
//  lightwatch Watch App
//
//  Created by Nicholas Nelson on 9/21/24.
//

//import HealthKit
//import Combine
//
//class HealthManager: ObservableObject {
//    private let healthStore = HKHealthStore()
//    @Published var timeInDaylight: Double = 0.0
//    @Published var exposureHistory: [SunExposureData] = [] // Published for UI updates
//    var weatherManager: WeatherManager? // Reference to weather manager for UV index
//
//    // Optional to track the current location, can be updated from another source
//    var currentLocation: (latitude: Double, longitude: Double) = (37.7749, -122.4194)
//    
//    init() {
//        requestAuthorization()
//    }
//    
//    func requestAuthorization() {
//        guard HKHealthStore.isHealthDataAvailable() else { return }
//        
//        let daylightType = HKObjectType.quantityType(forIdentifier: .environmentalAudioExposure)!
//        let typesToRead: Set = [daylightType]
//        
//        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
//            if success {
//                self.fetchTimeInDaylight()
//            } else if let error = error {
//                print("Error requesting authorization: \(error)")
//            }
//        }
//    }
//    
//    func fetchTimeInDaylight() {
//        let daylightType = HKQuantityType.quantityType(forIdentifier: .environmentalAudioExposure)!
//        let startDate = Calendar.current.startOfDay(for: Date())
//        let endDate = Date()
//        
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
//        
//        let query = HKStatisticsQuery(quantityType: daylightType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
//            if let sum = result?.sumQuantity() {
//                DispatchQueue.main.async {
//                    let minutes = sum.doubleValue(for: .minute())
//                    self.timeInDaylight = minutes
//                    self.updateExposureHistory(duration: minutes)
//                }
//            } else if let error = error {
//                print("Error fetching time in daylight: \(error)")
//            }
//        }
//        
//        healthStore.execute(query)
//    }
//    
//    // Updates exposure history with new data
//    func updateExposureHistory(duration: Double) {
//        let startDate = Calendar.current.startOfDay(for: Date())
//        let endDate = Date()
//        
//        let uvIndex = weatherManager?.uvIndex ?? 0.0 // Use UV index from weather manager
//        
//        let exposureData = SunExposureData(
//            date: startDate,
//            startTime: startDate,
//            endTime: endDate,
//            duration: duration,
//            uvIndex: uvIndex,
//            location: currentLocation
//        )
//        
//        exposureHistory.append(exposureData)
//    }
//    
//    // Call this function when location is updated
//    func updateLocation(latitude: Double, longitude: Double) {
//        currentLocation = (latitude: latitude, longitude: longitude)
//    }
//}
