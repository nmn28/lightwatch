//
//  InsightsView.swift
//  lightwatch Watch App
//
//  Created by Nicholas Nelson on 9/21/24.
//

import SwiftUI

struct InsightsView: View {
    var timeInDaylight: Double
    var goalInMinutes: Double = 60 // You can set this goal value as needed
    
    var progress: Double {
        min(timeInDaylight / (goalInMinutes * 60), 1.0) // Ensures the progress is within 0 and 1
    }
    
    var body: some View {
        VStack {
            // Progress Ring
            Text("Sun Intake")
                .font(.footnote)
                .foregroundColor(.white)
            ZStack {
                // Background circle
                Circle()
                    .stroke(lineWidth: 16)
                    .opacity(0.2)
                    .foregroundColor(.gray)
                
//                    .padding(.top, 20)
                // Progress circle with gradient
                Circle()
                    .trim(from: 0.0, to: CGFloat(progress))
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [.blue, .orange]),
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        ),
                        style: StrokeStyle(lineWidth: 16, lineCap: .round, lineJoin: .round)
                    )
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.easeInOut, value: progress)
                    
                // Center text
                VStack {
                    Text("\(Int(timeInDaylight / 60))")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                    Text("Min")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                }
            }
            .frame(width: 100, height: 100)
//            .padding(.top, 50)
            
            // Title
            .padding()
            
            // Description
            Text("To your goal")
                .font(.footnote)
                .foregroundColor(.white)
                .padding(.top, 10)
            
            Spacer()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Background color similar to watchOS
    }
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView(timeInDaylight: 27 * 60) // Preview with 27 minutes of daylight
    }
}
