internal import SwiftUI

struct ReminderListItem: View {
    
    // 1. بيانات التذكير لعرضها (Model)
    let item: ReminderItem
    let id: UUID = UUID()
    // 2. دالة العمل لتنفيذ المنطق في ViewModel
    // هذه الـ closure يتم استدعاؤها عندما يضغط المستخدم على علامة الصح
    let toggleAction: () -> Void
    
    var body: some View {
        HStack {
            
            // زر علامة الصح (Checkmark)
            Button(action: toggleAction) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(item.isChecked ? Color("geeen1") : .gray) // لونك المخصص
            }
            .buttonStyle(.plain) // لضمان أن الزر يعمل بشكل صحيح داخل الـ List
            
            VStack(alignment: .leading, spacing: 4) {
                
                // اسم النبتة
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .strikethrough(item.isChecked)
                
                HStack(spacing: 12) {
                    
                    // أيقونة الغرفة
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(item.location)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // أيقونة الإضاءة
                    HStack(spacing: 4) {
                        Image(systemName: "sun.max.fill")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(item.light)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Spacer()
            
            // كمية الماء (معرضة في مربع أسود)
            Text(item.waterAmount)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.6))
                .cornerRadius(6)
        }
        .padding(.vertical, 8)
    }
}

// ----------------------------------------------------
// Preview
// ----------------------------------------------------

struct ReminderListItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // تذكير غير مكتمل
            ReminderListItem(
                item: ReminderItem(
                    name: "Monstera",
                    location: "in Living Room",
                    light: "Partial sun",
                    waterAmount: "50-100 ml",
                    wateringDays: "Once a week",
                    isChecked: false
                ),
                toggleAction: {} // دالة فارغة للمعاينة
            )
            .previewLayout(.sizeThatFits)
            
            // تذكير مكتمل
            ReminderListItem(
                item: ReminderItem(
                    name: "Pothos",
                    location: "in Bedroom",
                    light: "Full sun",
                    waterAmount: "20-50 ml",
                    wateringDays: "Every day",
                    isChecked: true
                ),
                toggleAction: {}
            )
            .previewLayout(.sizeThatFits)
        }
        .padding()
        .background(Color.black)
    }
}
