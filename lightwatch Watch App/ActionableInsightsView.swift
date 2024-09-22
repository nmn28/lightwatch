//
//  ActionableInsightsView.swift
//  lightwatch Watch App
//
//  Created by Nicholas Nelson on 9/21/24.
//

import SwiftUI

struct ActionableInsightsView: View {
    @State private var actionableItems: [ActionableItem] = [
        ActionableItem(id: 0, tip: "Spend at least 15 more minutes in direct sunlight.", isCompleted: false),
        ActionableItem(id: 1, tip: "Wear sunscreen and avoid prolonged exposure.", isCompleted: false),
        ActionableItem(id: 2, tip: "Morning light exposure improves mood.", isCompleted: false)
    ]
    
    var body: some View {
        List {
            ForEach(actionableItems) { item in
                HStack {
                    Text(item.tip)
                        .font(.footnote)
                    
                    Spacer()
                    
                    // Checkmark button to mark as completed
                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                        .foregroundColor(.green)
                        .onTapGesture {
                            setCompletion(of: item, to: true)
                        }
                    
                    // X button to mark as not completed
                    Image(systemName: item.isCompleted ? "xmark.circle" : "xmark.circle.fill")
                        .foregroundColor(.red)
                        .onTapGesture {
                            setCompletion(of: item, to: false)
                        }
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle("Actionable Insights")
    }
    
    // Toggle completion status based on the parameter `completed`
    func setCompletion(of item: ActionableItem, to completed: Bool) {
        if let index = actionableItems.firstIndex(where: { $0.id == item.id }) {
            actionableItems[index].isCompleted = completed
        }
    }
}

struct ActionableItem: Identifiable {
    let id: Int
    var tip: String
    var isCompleted: Bool
}

struct ActionableInsightsView_Previews: PreviewProvider {
    static var previews: some View {
        ActionableInsightsView()
    }
}
