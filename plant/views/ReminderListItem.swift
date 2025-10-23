import SwiftUI
import Foundation

struct ReminderListItem: View {
    let item: ReminderItem
    let toggleAction: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // Leading icon
            ZStack {
                Circle()
                    .fill(Color("geeen1").opacity(0.2))
                    .frame(width: 40, height: 40)
                Image(systemName: "leaf")
                    .foregroundColor(Color("geeen1"))
            }

            // Main content
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }

                // Secondary details line
                HStack(spacing: 8) {
                    Label(item.location, systemImage: "location")
                    Label(item.light, systemImage: "sun.max")
                    Label(item.waterAmount, systemImage: "drop")
                }
                .font(.caption)
                .foregroundColor(.gray)

                // Optional watering schedule
                Text(item.wateringDays)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Checkmark toggle
            Button(action: toggleAction) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(item.isChecked ? Color("geeen1") : .gray)
                    .frame(width: 32, height: 32)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 10)
        .contentShape(Rectangle()) // improves tap target when wrapped in a Button
    }
}

struct ReminderListItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ReminderListItem(
                item: ReminderItem(
                    name: "Pothos",
                    location: "in Bedroom",
                    light: "Full sun",
                    waterAmount: "50-100 ml",
                    wateringDays: "Once a week",
                    isChecked: false
                ),
                toggleAction: {}
            )
            .padding()
            .background(Color.black)
            .previewDisplayName("Unchecked")

            ReminderListItem(
                item: ReminderItem(
                    name: "Snake Plant",
                    location: "in Office",
                    light: "Shade",
                    waterAmount: "20-50 ml",
                    wateringDays: "Every 2 days",
                    isChecked: true
                ),
                toggleAction: {}
            )
            .padding()
            .background(Color.black)
            .previewDisplayName("Checked")
        }
        .preferredColorScheme(.dark)
    }
}
