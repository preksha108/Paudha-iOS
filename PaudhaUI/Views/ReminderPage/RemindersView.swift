//
//  RemindersView.swift
//  REM
//
//  Created by SHHH!! private on 05/03/24.
//

import SwiftUI

struct RemindersView: View {
    @ObservedObject var reminderStore = ReminderStore()
    @State private var isAddReminderSheetPresented = false

    var body: some View {
        NavigationView {
            List {
                Section(header: ReminderSummaryView(reminderStore: reminderStore)) {
                    ForEach(reminderStore.reminders) { reminder in
                        ReminderRowView(reminderStore: reminderStore, reminder: reminder)
                    }
                    .onDelete { indexSet in
                        reminderStore.deleteReminder(at: indexSet)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Reminders")
            .navigationBarItems(trailing: Button(action: {
                isAddReminderSheetPresented = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isAddReminderSheetPresented) {
                AddReminderView(reminderStore: reminderStore)
            }
            .onAppear{
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ _, _ in }
            }
        }
    }
}

struct RemindersView_Preview: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}

