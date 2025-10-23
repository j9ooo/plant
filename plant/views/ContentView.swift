internal import SwiftUI

struct ContentView: View {
    
    // 1. استقبال الـ ViewModel من ملف plantApp.swift
    @ObservedObject var viewModel: ReminderListViewModel
    
    // 2. حالة للتحكم في التنقل، خصوصاً بعد إضافة أول تذكير
    @State private var shouldNavigateToTodayView = false
    
    // خاصية مساعدة لتحديد ما إذا كان يجب عرض شاشة البداية (My Plants)
    var shouldShowStarterScreen: Bool {
        return viewModel.reminders.isEmpty && !shouldNavigateToTodayView
    }
    
    // حالة لعرض شيت إضافة التذكير من شاشة البداية
    @State private var showSetReminderSheet = false
    
    var body: some View {
        NavigationStack {
            
            // إذا كانت قائمة التذكيرات فارغة، اعرض شاشة "ابدأ رحلتك"
            if shouldShowStarterScreen {
                
                // تصميم شاشة البداية (My Plants)
                VStack(spacing: 0) {
                    Spacer().frame(height: 50)
                    
                    Text("My Plants 🌿")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    Image("plant1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.bottom, 50)
                    
                    // زر يفتح SetReminderView كشيت
                    Button {
                        showSetReminderSheet = true
                    } label: {
                        Text("Start your plant journey!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 60)
                            .padding(.vertical, 14)
                            .background(Color("geeen1"))
                            .cornerRadius(50)
                    }
                    .padding(.bottom, 60)
                    
                    Spacer()
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
                // تقديم SetReminderView كشيت من شاشة البداية
                .sheet(isPresented: $showSetReminderSheet) {
                    SetReminderView(
                        onSave: { newItem in
                            viewModel.addReminder(newItem)
                            // بعد الحفظ، غلق الشيت وتوجيه المستخدم إلى TodayReminderView
                            shouldNavigateToTodayView = true
                        },
                        shouldNavigateToTodayView: $shouldNavigateToTodayView
                    )
                }
                
            } else {
                // إذا كان هناك تذكيرات، اعرض شاشة اليوم
                TodayReminderView(viewModel: viewModel)
            }
        }
        .preferredColorScheme(.dark)
    }
}

// ----------------------------------------------------
// Preview
// ----------------------------------------------------
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ReminderListViewModel())
    }
}
