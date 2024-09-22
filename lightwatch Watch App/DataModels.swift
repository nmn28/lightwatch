//
//  DataModels.swift
//  lightwatch Watch App
//
//  Created by Nicholas Nelson on 9/21/24.
//

import Foundation

struct UserHealthGoals {
    var improveSleep: Bool
    var boostMood: Bool
    var vitaminD: Bool
}

struct SunExposureData {
    let date: Date
    let startTime: Date
    let endTime: Date
    let duration: TimeInterval
    let uvIndex: Double
    let location: (latitude: Double, longitude: Double)
}

struct DailyExposureScore {
    let date: Date
    let score: Double // Calculated based on time in daylight vs. available sunlight
}

struct SunlightThresholds {
    static let minimumDuration = 15 * 60.0 // 15 minutes in seconds
    static let minimumUVIndex = 3.0 // Minimum UV index required
    static let idealMorningTime = (start: 6, end: 10) // 6 AM - 10 AM
    static let idealAfternoonTime = (start: 12, end: 15) // 12 PM - 3 PM
}

func evaluateSunExposure(for exposureData: SunExposureData, healthGoals: UserHealthGoals) -> String {
    // Check if the duration meets the minimum requirement
    if exposureData.duration < SunlightThresholds.minimumDuration {
        return "Insufficient exposure time. Aim for at least \(Int(SunlightThresholds.minimumDuration / 60)) minutes."
    }
    
    // Check if the UV index meets the minimum requirement
    if exposureData.uvIndex < SunlightThresholds.minimumUVIndex {
        return "The UV index was too low. Try to get sunlight when the UV index is above \(SunlightThresholds.minimumUVIndex)."
    }
    
    // Check if exposure happened in ideal time frames
    let hour = Calendar.current.component(.hour, from: exposureData.startTime)
    if healthGoals.improveSleep && !(SunlightThresholds.idealMorningTime.start <= hour && hour <= SunlightThresholds.idealMorningTime.end) {
        return "For better sleep, try to get sunlight exposure between 6 AM and 10 AM."
    }
    
    if healthGoals.vitaminD && !(SunlightThresholds.idealAfternoonTime.start <= hour && hour <= SunlightThresholds.idealAfternoonTime.end) {
        return "For vitamin D synthesis, get sunlight between 12 PM and 3 PM."
    }
    
    // If all conditions are met
    return "Great job! You've met your sunlight exposure goals for today."
}


func analyzeHistoricalData(exposureHistory: [SunExposureData]) -> String {
    var totalExposureTime: TimeInterval = 0
    var daysMetGoal = 0
    
    for data in exposureHistory {
        totalExposureTime += data.duration
        
        if data.duration >= SunlightThresholds.minimumDuration && data.uvIndex >= SunlightThresholds.minimumUVIndex {
            daysMetGoal += 1
        }
    }
    
    let averageExposure = totalExposureTime / Double(exposureHistory.count)
    let percentageDaysMetGoal = Double(daysMetGoal) / Double(exposureHistory.count) * 100
    
    return """
    On average, you received \(Int(averageExposure / 60)) minutes of sunlight per day.
    You've met your sunlight goals on \(Int(percentageDaysMetGoal))% of the days.
    """
}
