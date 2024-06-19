import SwiftUI
struct ReminderSummaryView: View {
    @ObservedObject var reminderStore: ReminderStore

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Due Today: \(dueTodayCount())")
                Spacer()
                Text("Remaining: \(remainingCount())")
                Spacer()
                Text("Completed: \(completedCount())")
            }
            .foregroundColor(.secondary)
        }
    }

    func dueTodayCount() -> Int {
        let today = Calendar.current.startOfDay(for: Date())
        return reminderStore.reminders.filter { Calendar.current.isDate($0.time, inSameDayAs: today) }.count
    }

    func remainingCount() -> Int {
        return reminderStore.reminders.filter { !$0.isCompleted }.count
    }

    func completedCount() -> Int {
        return reminderStore.reminders.filter { $0.isCompleted }.count
    }
}

