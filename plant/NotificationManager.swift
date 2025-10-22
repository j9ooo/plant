//
//  NotificationManager.swift
//  plant
//
//  Created by Jumanah aldowaish on 30/04/1447 AH.
//


import UserNotifications
import Foundation

class NotificationManager {
    
    // 1. طلب الصلاحية
    static func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification Authorization Granted!")
            } else if let error = error {
                print("Notification Authorization Error: \(error.localizedDescription)")
            }
        }
    }
    
    // 2. جدولة إشعار (يظهر بعد 10 ثوانٍ لغرض الاختبار)
    static func scheduleReminder(for reminder: ReminderItem) {
        
        // تأكد من وجود صلاحية
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            
            // المحتوى
            let content = UNMutableNotificationContent()
            content.title = "Time to water your plant! 💧"
            content.body = "Don't forget to water your \(reminder.name) located \(reminder.location)."
            content.sound = .default
            
            // وقت الظهور (اختبار: بعد 10 ثوانٍ)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            
            // الطلب
            let request = UNNotificationRequest(
                identifier: reminder.id.uuidString,
                content: content,
                trigger: trigger
            )
            
            // إضافة الطلب
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled successfully for \(reminder.name)")
                }
            }
        }
    }
}
