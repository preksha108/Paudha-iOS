//
//  ReminderDetailsView.swift
//  REM
//
//  Created by SHHH!! private on 05/03/24.
//

import SwiftUI



struct ReminderDetailsView: View {

    var reminder: Reminder



    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 20) {

                // Image Section

                ZStack {

                    RoundedRectangle(cornerRadius: 30)

                        .fill(Color.gray.opacity(0.2))

                        .frame(width:360,height: 280) // Set a fixed height for the frame

                        .padding(.horizontal)

                        .shadow(radius: 5) // Add a drop shadow

                    

                    if let image = reminder.image {

                        Image(uiImage: image)

                            .resizable()

                            .aspectRatio(contentMode: .fill)

                            .frame(maxWidth: .infinity)

                            .frame(height: 200)

                            .clipped()

                    } else {

                        Text("No Image")

                            .foregroundColor(.white)

                            .padding()

                    }

                }

                

                // Reminder Details

                VStack(alignment: .leading, spacing: 10) {

                    Text("Location:")

                        .font(.headline)

                    Text("\(reminder.location)")

                        .foregroundColor(.secondary)

                    

                    Text("Action:")

                        .font(.headline)

                    Text("\(reminder.action)")

                        .foregroundColor(.secondary)

                    

                    Text("Repeat Options:")

                        .font(.headline)

                    ForEach(reminder.repeatOptions, id: \.self) { date in

                        Text("\(date)")

                            .foregroundColor(.secondary)

                    }

                    

                    Text("Time:")

                        .font(.headline)

                    Text("\(reminder.time)")

                        .foregroundColor(.secondary)

                    

                    Text("Last Watering:")

                        .font(.headline)

                    Text("\(reminder.lastWatering)")

                        .foregroundColor(.secondary)

                }

                .padding(.horizontal)

                .padding(.bottom)

            }

            .padding()

            .navigationBarTitle(reminder.name)

        }

    }

}



struct ReminderDetailsView_Previews: PreviewProvider {

    static var previews: some View {

        let reminder = Reminder(name: "Plant Care", imageData: nil, location: "Living Room", action: "Water", repeatOptions: [Date()], time: Date(), lastWatering: Date())

        return ReminderDetailsView(reminder: reminder)

    }

}
