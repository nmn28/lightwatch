//
//  TipsView.swift
//  lightwatch Watch App
//
//  Created by Nicholas Nelson on 9/21/24.
//

import SwiftUI

struct TipsView: View {
    @State private var personalizedTips: [String] = []

    var body: some View {
        VStack {
//            Text("Personalized Tips")
//                .font(.subheadline)
//                .padding(.bottom, 10)
            
            List(personalizedTips, id: \.self) { tip in
                Text(tip)
                    .font(.body)
                    .padding(.vertical, 5)
            }
        }
        .navigationTitle("Tips")
        .onAppear {
            generatePersonalizedTips()
        }
    }
    
    func generatePersonalizedTips() {
        // Replace with actual logic based on user's data
        personalizedTips = [
            "Take a short walk outside during lunch.",
            "Avoid screen time 1 hour before bed.",
            "Get natural sunlight within 1 hour of waking up."
        ]
    }
}
struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView()
    }
}
