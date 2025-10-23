import Foundation

struct ReminderItem: Identifiable, Codable {
    var id: UUID = UUID() // تثبيت المعرّف حتى لا يتغير أثناء التحرير
    var name: String
    var location: String
    var light: String
    var waterAmount: String
    var wateringDays: String
    // ✅ يجب أن تكون var إذا كنت تريد تغييرها (مثل عند وضع علامة صح)
    var isChecked: Bool = false
    var lastWateredDate: Date = Date()

    // يمكنك إضافة init مخصص لتسهيل الإنشاء
    init(name: String, location: String, light: String, waterAmount: String, wateringDays: String, isChecked: Bool = false, lastWateredDate: Date = Date()) {
        self.name = name
        self.location = location
        self.light = light
        self.waterAmount = waterAmount
        self.wateringDays = wateringDays
        self.isChecked = isChecked
        self.lastWateredDate = lastWateredDate
    }
}
