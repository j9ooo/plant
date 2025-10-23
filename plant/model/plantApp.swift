//
//  plantApp.swift
//  plant
//
//  Created by Jumanah aldowaish on 27/04/1447 AH.
//

internal import SwiftUI
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // تعيين المفوض لعرض الإشعار كبانر حتى والتطبيق في المقدمة
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // عرض الإشعار كبانر وصوت وشارة عندما يكون التطبيق في المقدمة
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.banner, .sound, .badge]
    }
}

@main
struct plantApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // 💡 الـ ViewModel هو مصدر الحقيقة الآن
    @StateObject var viewModel = ReminderListViewModel()
    
    init() {
        // طلب صلاحيات الإشعارات عند بدء التطبيق
        NotificationManager.requestAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            // نمرر الـ ViewModel إلى أول View
            ContentView(viewModel: viewModel)
                .preferredColorScheme(.dark) // تطبيق النمط الليلي على كل الواجهات
        }
    }
}
