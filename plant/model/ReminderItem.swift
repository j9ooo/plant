import Foundation
import SwiftUI

struct ReminderItem: Identifiable, Codable {
    let id = UUID()
    var name: String
    var location: String
    var light: String
    var waterAmount: String
    // 🚨 الخاصية المسببة للخطأ: يجب أن تكون معرفة هنا
    var wateringDays: String
    var lastWateredDate: Date = Date()
    
    var isChecked: Bool = false
}
