//
//  ReminderListViewModel.swift
//  plant
//
//  Created by Jumanah aldowaish on 01/05/1447 AH.
//
import Foundation
import Combine // لإدارة التحديثات
internal import SwiftUI

class ReminderListViewModel: ObservableObject {
    
    // 1. البيانات القابلة للملاحظة (Source of Truth)
    // الآن، الـ ViewModel هو من يملك البيانات، والـ View يراقبها.
    @Published var reminders: [ReminderItem] = [] {
        didSet {
            // يمكن إضافة منطق الحفظ هنا
            saveReminders()
        }
    }
    
    // 2. إدارة الحالة (مثل التحميل من UserDefaults/CoreData)
    init() {
        loadReminders()
    }
    
    // 3. دوال العمليات (المنطق)
    
    func toggleCheckmark(for item: ReminderItem) {
        if let index = reminders.firstIndex(where: { $0.id == item.id }) {
            reminders[index].isChecked.toggle()
        }
    }
    
    func addReminder(_ newReminder: ReminderItem) {
        reminders.append(newReminder)
        // عند إضافة تذكير، نقوم بجدولة إشعاره
        NotificationManager.scheduleReminder(for: newReminder)
    }
    
    func deleteReminder(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
    }
    
    // 4. الحسابات المنطقية (مثل شريط التقدم)
    var progressAmount: Double {
        reminders.isEmpty ? 0.0 : Double(reminders.filter { $0.isChecked }.count) / Double(reminders.count)
    }
    
    var headerText: String {
        let checkedCount = reminders.filter { $0.isChecked }.count
        let totalCount = reminders.count
        
        if totalCount == 0 {
            return "Add your first plant to get started! 🌱"
        } else if checkedCount == 0 {
            return "Your plants are waiting for a sip. 💦"
        } else {
            return "\(checkedCount) of your plants feel loved today ✨"
        }
    }
    
    // دوال الحفظ والتحميل (Codable)
    private func saveReminders() {
        // منطق حفظ المصفوفة
    }
    
    private func loadReminders() {
        // منطق تحميل المصفوفة
    }
}
