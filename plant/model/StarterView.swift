import SwiftUI
import Foundation

struct StarterView: View {
    
    @State private var starterReminders: [ReminderItem] = []
    
    @State private var isShowingSetReminderSheet = false
    @State private var navigateToTodayView = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                Color.clear.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("My Plants 🌱")
                            .font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                            .padding(.horizontal).padding(.top, 50)
                        Rectangle().fill(Color(white: 0.2)).frame(height: 1).padding(.top, 10)
                    }
                    
                    Spacer()
                    
                    Image("plant3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding(.bottom, 190)
                    
                    Button(action: {
                        isShowingSetReminderSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                        
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color.geeen1)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding(.trailing, -290)
                            .padding(.vertical, 40)
                        .padding(.leading,190)
                    }
                    
                    .buttonStyle(.plain)
                    
                    
                }
            }
            .preferredColorScheme(.dark)
            
            .navigationDestination(isPresented: $navigateToTodayView) {
                TodayReminderView(reminders: $starterReminders)
            }
            
            .sheet(isPresented: $isShowingSetReminderSheet) {
                SetReminderView(
                    reminders: $starterReminders,
                    shouldNavigateToTodayView: $navigateToTodayView
                )
            }
        }
    }
}

#Preview {
    StarterView()
}
