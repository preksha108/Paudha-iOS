//
//  ReminderRowView.swift
//  REM
//
//  Created by SHHH!! private on 05/03/24.
//
import SwiftUI

struct ReminderRowView: View {
    @ObservedObject var reminderStore: ReminderStore
    var reminder: Reminder

    var body: some View {
        HStack {
            Image(uiImage: reminder.image ?? UIImage(systemName: "photo")!) // Placeholder image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)

            Button(action: {
                reminderStore.toggleCompletion(for: reminder)
                if reminder.isCompleted {
                    if let index = reminderStore.reminders.firstIndex(where: { $0.id == reminder.id }) {
                        reminderStore.deleteReminder(at: IndexSet([index]))
                    }
                }
            }) {
                Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(BorderlessButtonStyle())

            Text(reminder.name)

            Spacer()

            NavigationLink(destination: ReminderDetailsView(reminder: reminder)) {
                EmptyView()
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}
