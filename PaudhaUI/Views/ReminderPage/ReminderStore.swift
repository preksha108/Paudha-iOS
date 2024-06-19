import CoreData
import SwiftUI

class ReminderStore: ObservableObject {
    @Published var reminders: [Reminder] = [] {
        didSet {
            saveReminders()
        }
    }
    
    private let remindersKey = "remindersKey"

    init() {
        loadReminders()
    }

    private func loadReminders() {
        if let data = UserDefaults.standard.data(forKey: remindersKey) {
            if let decoded = try? JSONDecoder().decode([Reminder].self, from: data) {
                reminders = decoded
            }
        }
    }

    private func saveReminders() {
        if let encoded = try? JSONEncoder().encode(reminders) {
            UserDefaults.standard.set(encoded, forKey: remindersKey)
        }
    }

    func addReminder(reminder: Reminder) {
        reminders.append(reminder)
    }

    func deleteReminder(at indexSet: IndexSet) {
        reminders.remove(atOffsets: indexSet)
    }

    func toggleCompletion(for reminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].isCompleted.toggle()
        }
    }

    func editReminder(for reminder: Reminder, newName: String, newLocation: String, newAction: String, newRepeatOptions: [Date], newTime: Date, newLastWatering: Date) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].name = newName
            reminders[index].location = newLocation
            reminders[index].action = newAction
            reminders[index].repeatOptions = newRepeatOptions
            reminders[index].time = newTime
            reminders[index].lastWatering = newLastWatering
        }
    }
}
