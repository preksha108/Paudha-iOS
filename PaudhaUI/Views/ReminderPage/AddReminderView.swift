//
//  AddReminderView.swift
//  REM
//
//  Created by SHHH!! private on 05/03/24.
//
import SwiftUI
import UserNotifications
import EventKit

struct AddReminderView: View {
    @ObservedObject var reminderStore: ReminderStore
    @State private var name = "Rose" // Initialized with a valid name
    @State private var location = ""
    @State private var action = "Watering" // Initialized with a valid action
    @State private var repeatOptions: [Date] = [Date()]
    @State private var time = Date()
    @State private var lastWatering = Date()
    @State private var showImagePicker = false
    @State private var image: UIImage?
    @State private var isReminderAdded = false
    @Environment(\.presentationMode) var presentationMode
    let names = ["Rose", "SnakePlant"]
    let actions = ["Watering", "Misting", "Fertilizing", "Pruning"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Reminder Details")) {
                    Picker("Name", selection: $name) {
                        ForEach(names, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Location", text: $location)
                    
                    Picker("Action", selection: $action) {
                        ForEach(actions, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section(header: Text("Schedule")) {
                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                    DatePicker("Last Watering", selection: $lastWatering, displayedComponents: .date)
                    
                    ForEach(repeatOptions.indices, id: \.self) { index in
                        DatePicker("Repeat Option", selection: $repeatOptions[index], displayedComponents: .date)
                    }
                    
                    Button(action: {
                        repeatOptions.append(Date())
                    }) {
                        Text("Add Another Date")
                    }
                }
                
                Section(header: Text("Photo")) {
                    Button(action: {
                        self.showImagePicker = true
                    }) {
                        Text("Add Photo")
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePickerRem(image: self.$image)
                    }
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                }
            }
            .navigationBarTitle("Add Reminder")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Add Reminder") {
                    let newReminder = Reminder(name: self.name, imageData: self.image?.jpegData(compressionQuality: 1.0), location: self.location, action: self.action, repeatOptions: self.repeatOptions, time: self.time, lastWatering: self.lastWatering)
                    self.reminderStore.addReminder(reminder: newReminder)
                    self.isReminderAdded = true
                    self.scheduleNotificationForReminder() // Schedule notification after saving reminder
                    self.addReminderToCalendar() // Add reminder to calendar after saving reminder
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(isReminderAdded)
            )
            .onDisappear {
                // Clean up or additional actions if needed
            }
        }
    }
    
    func scheduleNotificationForReminder() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder: \(name)"
        content.body = "Don't forget to \(action) at \(location)"
        content.sound = .default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }

    func addReminderToCalendar() {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .reminder) { granted, error in
            if granted && error == nil {
                let reminder = EKReminder(eventStore: eventStore)
                reminder.title = self.name
                reminder.notes = "Action: \(self.action)\nLocation: \(self.location)"

                let calendar = eventStore.defaultCalendarForNewReminders()
                reminder.calendar = calendar

                let reminderTime = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self.time)
                reminder.dueDateComponents = reminderTime

                do {
                    try eventStore.save(reminder, commit: true)
                    DispatchQueue.main.async {
                        self.isReminderAdded = true
                    }
                } catch {
                    print("Error saving reminder to calendar: \(error.localizedDescription)")
                }
            } else {
                print("Access denied or error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
