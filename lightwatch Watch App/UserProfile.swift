//
//  UserProfile.swift
//  lightwatch Watch App
//
//  Created by Nicholas Nelson on 9/21/24.
//

import Foundation
import UIKit

struct UserProfile {
    var name: String
    var profileImage: UIImage
    var age: Int // Add the missing properties
    var gender: String
    var skinType: String
    var location: (latitude: Double, longitude: Double)
    var dailyExposureScores: [DailyExposureScore]
    var goals: UserHealthGoals
}
