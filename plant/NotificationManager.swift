import UserNotifications
import Foundation

class NotificationManager {
    
    static func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ Notification Authorization Granted")
            } else if let error = error {
                print("❌ Notification Authorization Error: \(error.localizedDescription)")
            } else {
                print("❌ Notification Authorization Denied by user")
            }
        }
        
        // اختياري: اطبع الإعدادات الحالية
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("🔧 Notification settings status: \(settings.authorizationStatus.rawValue)")
        }
    }
    
    static func scheduleReminder(for reminder: ReminderItem, after seconds: TimeInterval = 10) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("⚠️ Notifications not authorized. Status: \(settings.authorizationStatus.rawValue)")
                return
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Hey! Let's water your plant! 💧"
            content.body = "Don't forget your \(reminder.name) today."
            content.sound = .default
            
            // مرفق الصورة معطّل مؤقتاً لتفادي أي فشل بسبب عدم وجود الملف في الباندل كملف (وليس Asset)
            /*
            if let imageURL = Bundle.main.url(forResource: "Image", withExtension: "png") {
                do {
                    let attachment = try UNNotificationAttachment(identifier: "plantImage", url: imageURL, options: nil)
                    content.attachments = [attachment]
                } catch {
                    print("Error adding notification attachment: \(error.localizedDescription)")
                }
            } else {
                print("Attachment not found in bundle.")
            }
            */
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
            let request = UNNotificationRequest(
                identifier: reminder.id.uuidString,
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("❌ Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("✅ Notification scheduled in \(seconds)s for \(reminder.name)")
                }
            }
        }
    }
    
    // دالة اختبار سريعة لجدولة إشعار بعد 3 ثوانٍ
    static func scheduleTestNotification() {
        let test = ReminderItem(
            name: "Test Plant",
            location: "in Office",
            light: "Full sun",
            waterAmount: "50-100 ml",
            wateringDays: "Every day"
        )
        scheduleReminder(for: test, after: 3)
    }
}
