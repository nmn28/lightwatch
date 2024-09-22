//
//  UserNotifications.swift
//  lightwatch Watch App
//
//  Created by Nicholas Nelson on 9/21/24.
//

import UserNotifications

func scheduleMorningNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Good morning!"
    content.body = "Get 30 minutes of natural sunlight before 10 AM."
    content.sound = .default
    
    var dateComponents = DateComponents()
    dateComponents.hour = 8 // 8 AM
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    let request = UNNotificationRequest(identifier: "morningNotification", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}
