//
//  SettingsView.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var vm: RootViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Info")) {
                    Picker("Sex", selection: $vm.userSettings.gender,
                           content: {
                        ForEach([Gender.Male, Gender.Female], id: \.self) { gender in
                            Text(gender.rawValue)
                        }
                    })
                    DatePicker("Birthday", selection: $vm.userSettings.birthday, in: ...(Date() - TimeInterval(8 * 3.156e+7)), displayedComponents: .date)
                    Picker("Height", selection: $vm.userSettings.height, content: {
                        ForEach(100...250, id: \.self) { height in
                            Text("\(height) cm")
                        }
                    })
                    Picker("Weight", selection: $vm.userSettings.weight, content: {
                        ForEach(30...200, id: \.self) { weight in
                            Text("\(weight) kg")
                        }
                    })
                }
                Section(header: Text("Activity Level")) {
                    Stepper {
                        Text(vm.userSettings.activityLevel.rawValue)
                    } onIncrement: {
                        vm.incActivityLevel()
                    } onDecrement: {
                        vm.decActivityLevel()
                    }
                }
                Section(header: Text("Diet Goal")) {
                    Stepper {
                        Text(vm.userSettings.goal.rawValue)
                    } onIncrement: {
                        vm.incGoal()
                    } onDecrement: {
                        vm.decGoal()
                    }
                    Text("Your daily calory intake: \(vm.userSettings.calories)")
                }
                Button {
                    vm.saveUserSettings()
                    dismiss()
                } label: {
                    Text("Save")
                }

            }
            .navigationTitle("Settings")
            .onAppear {
                vm.getUserSettings()
            }
        }
    }
}

#Preview {
    RootView()
}
