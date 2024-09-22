//
//  UserProfileView.swift
//  lightwatch Watch App
//
//  Created by Nicholas Nelson on 9/21/24.
//

import SwiftUI

struct UserProfileView: View {
    var user: UserProfile

    var body: some View {
        VStack {
            ScrollView {
//                ProfileHeaderView(user: user)
//                
                Text("Progress Over Time")
                    .font(.headline)
                    
                
                DailyExposureGraphView(scores: user.dailyExposureScores)
//                    .frame(height: 200)
                
                Spacer()
            }
        }
//        .navigationTitle("User Profile")
//        .padding()
    }
}

#Preview {
    UserProfileView(user: UserProfile(
        name: "Nicholas",
        profileImage: UIImage(systemName: "person.circle.fill")!,
        age: 26, // Provide the age
        gender: "Male", // Provide the gender
        skinType: "Type II", // Provide the skin type
        location: (latitude: 37.7749, longitude: -122.4194), // Provide the location
        dailyExposureScores: [
            DailyExposureScore(date: Date().addingTimeInterval(-86400), score: 80),
            DailyExposureScore(date: Date().addingTimeInterval(-172800), score: 60),
            DailyExposureScore(date: Date().addingTimeInterval(-259200), score: 90)
        ],
        goals: UserHealthGoals(improveSleep: true, boostMood: true, vitaminD: true) // Provide user goals
    ))
}


struct ProfileHeaderView: View {
    var user: UserProfile

    var body: some View {
        HStack {
            Image(uiImage: user.profileImage)
                .resizable()
                .clipShape(Circle())
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.title)
                Text("Sunlight Enthusiast")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

//#Preview {
//    ProfileHeaderView(user: UserProfile(
//        name: "Nicholas",
//        profileImage: UIImage(systemName: "person.circle.fill")!,
//        dailyExposureScores: []
//    ))
//}

import SwiftUI
import Charts

struct DailyExposureGraphView: View {
    var scores: [DailyExposureScore]

    var body: some View {
        Chart {
            ForEach(scores, id: \.date) { score in
                LineMark(
                    x: .value("Date", score.date, unit: .day),
                    y: .value("Score", score.score)
                )
                .symbol(Circle())
                .interpolationMethod(.catmullRom)
            }
        }
        .chartYScale(domain: 0...100)
        .frame(height: 200)
        .padding()
    }
}

#Preview {
    DailyExposureGraphView(scores: [
        DailyExposureScore(date: Date().addingTimeInterval(-86400), score: 80),
        DailyExposureScore(date: Date().addingTimeInterval(-172800), score: 60),
        DailyExposureScore(date: Date().addingTimeInterval(-259200), score: 90)
    ])
}
