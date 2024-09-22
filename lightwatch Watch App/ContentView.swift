//
//  ContentView.swift
//  lightwatch Watch App
//
//  Created by Nicholas Nelson on 9/21/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var weatherManager = WeatherManager()
    @State private var sunEvaluation: String = ""
    @State private var timeInDaylight: Double = 30 * 60 // Example value, 30 minutes
    @State private var userProfile = UserProfile(
        name: "Nicholas",
        profileImage: UIImage(systemName: "person.circle.fill")!,
        age: 26,
        gender: "Male",
        skinType: "Type II",
        location: (latitude: 37.7749, longitude: -122.4194),
        dailyExposureScores: [
            DailyExposureScore(date: Date().addingTimeInterval(-86400), score: 80),
            DailyExposureScore(date: Date().addingTimeInterval(-172800), score: 60),
            DailyExposureScore(date: Date().addingTimeInterval(-259200), score: 90)
        ],
        goals: UserHealthGoals(improveSleep: true, boostMood: true, vitaminD: true)
    )
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    // Progress Ring
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 4)
                            .opacity(0.3)
                            .foregroundColor(.blue)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(timeInDaylight / (15 * 60), 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                            .foregroundColor(.yellow)
                            .rotationEffect(Angle(degrees: -90))
                            .animation(.easeInOut, value: timeInDaylight)
                        
                        VStack {
                            Image(systemName: "sun.max.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.yellow)
                            Text("\(Int(timeInDaylight / 60)) min")
                                .font(.footnote)
                                .bold()
                        }
                    }
                    .frame(width: 60, height: 60)
                    
                    // Current Status
                    Text("You've spent \(Int(timeInDaylight / 60)) minutes in daylight today.")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                    
                    // Next Best Action
                    Text(sunEvaluation)
                        .font(.caption)
                        .foregroundColor(.green)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                    
                    // Buttons for navigating to other screens with SF Symbols
                    HStack(spacing: 20) {
                        NavigationLink(destination: InsightsView(timeInDaylight: timeInDaylight)) {
                            VStack {
                                Image(systemName: "chart.bar")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        NavigationLink(destination: TipsView()) {
                            VStack {
                                Image(systemName: "lightbulb")
                                    .font(.title2)
                                    .foregroundColor(.orange)
                            }
                        }
                        
                        NavigationLink(destination: ActionableInsightsView()) { // No argument passed
                            VStack {
                                Image(systemName: "bolt.fill")
                                    .font(.title2)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .padding(.top, 10)
                    
                    // Navigate to User Profile View with an SF Symbol
                    NavigationLink(destination: UserProfileView(user: userProfile)) {
                        VStack {
                            Image(systemName: "person.circle")
                                .font(.title2)
                                .foregroundColor(.purple)
                            Text("Profile")
                                .font(.footnote)
                                .foregroundColor(.purple)
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
                .onAppear {
                    weatherManager.locationManager.startUpdatingLocation()
                    checkSunExposure()
                }
                .navigationTitle("Lightwatch")
            }
        }
    }
    
    func checkSunExposure() {
        let todayExposure = SunExposureData(
            date: Date(),
            startTime: Date(),
            endTime: Date().addingTimeInterval(timeInDaylight),
            duration: timeInDaylight,
            uvIndex: weatherManager.uvIndex,
            location: (latitude: 37.7749, longitude: -122.4194)
        )
        
        sunEvaluation = evaluateSunExposure(for: todayExposure, healthGoals: userProfile.goals)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
