//
//  SettingsView.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import SwiftUI

struct SettingsView: View {

    @Environment(\.dismiss) var dismiss
    
    @State private var userSettings = UserSettings(
        gender: Gender.Male, birthday: Date().addingTimeInterval(-(365 * 24 * 60 * 60 * 5)), height: 160, weight: 70, activityLevel: ActivityLevel.ModeratelyActive, goal: Goal.Maintain, calories: 2000)
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Info")) {
                    Picker("Sex", selection: $userSettings.gender,
                           content: {
                        ForEach([Gender.Male, Gender.Female], id: \.self) { gender in
                            Text(gender.rawValue)
                        }
                    })
                    DatePicker("Birthday", selection: $userSettings.birthday, in: ...(Date() - TimeInterval(8 * 3.156e+7)), displayedComponents: .date)
                    Picker("Height", selection: $userSettings.height, content: {
                        ForEach(100...250, id: \.self) { height in
                            Text("\(height) cm")
                        }
                    })
                    Picker("Weight", selection: $userSettings.weight, content: {
                        ForEach(30...200, id: \.self) { weight in
                            Text("\(weight) kg")
                        }
                    })
                }
                Section(header: Text("Activity Level")) {
                    Stepper {
                        Text(userSettings.activityLevel.rawValue)
                    } onIncrement: {
                        incActivityLevel()
                    } onDecrement: {
                        decActivityLevel()
                    }
                }
                Section(header: Text("Diet Goal")) {
                    Stepper {
                        Text(userSettings.goal.rawValue)
                    } onIncrement: {
                        incGoal()
                    } onDecrement: {
                        decGoal()
                    }
                    Text("Your daily calory intake: \(userSettings.calories)")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        saveUserSettings()
                        dismiss()
                    } label: {
                        HStack {
                            Text("Save")
                            Image(systemName: "chevron.forward")
                        }
                    }
                }
            }
            .onAppear {
                getUserSettings()
                calculateCalRequirement()
            }
            .onChange(of: userSettings) { _, _ in
                calculateCalRequirement()
            }
        }
    }
}

extension SettingsView {
    
    func calculateCalRequirement() {
        let age = Calendar.current.dateComponents([.year], from: userSettings.birthday, to: Date()).year!
        
        if userSettings.gender == Gender.Male {
            let weightCalculation = 13.75 * Double(userSettings.weight)
            let heightCalculation = 5 * Double(userSettings.height)
            let ageCalculation = 6.75 * Double(age)
            
            let baseCalories = (66.47 + weightCalculation + heightCalculation - ageCalculation) / 24
            let normalHours = baseCalories * 18.5
            let activeHours = baseCalories * 5.5
            
            switch userSettings.activityLevel {
            case .LightlyActive:
                userSettings.calories = addSurplus(number: Int(normalHours + activeHours * 1.4))
                return
            case .ModeratelyActive:
                userSettings.calories = addSurplus(number: Int(normalHours + activeHours * 1.6))
                return
            case .VeryActive:
                userSettings.calories = addSurplus(number: Int(normalHours + activeHours * 1.8))
                return
            case .ExtremelyActive:
                userSettings.calories = addSurplus(number: Int(normalHours + activeHours * 2))
                return
            }
        } else {
            let weightCalculation = 9.56 * Double(userSettings.weight)
            let heightCalculation = 1.85 * Double(userSettings.height)
            let ageCalculation = 4.68 * Double(age)
            
            let baseCalories = (655.1 + weightCalculation + heightCalculation - ageCalculation) / 24
            let normalHours = baseCalories * 18.5
            let activeHours = baseCalories * 5.5
            
            switch userSettings.activityLevel {
            case .LightlyActive:
                userSettings.calories = addSurplus(number: Int(normalHours + activeHours * 1.4))
                return
            case .ModeratelyActive:
                userSettings.calories = addSurplus(number: Int(normalHours + activeHours * 1.6))
                return
            case .VeryActive:
                userSettings.calories = addSurplus(number: Int(normalHours + activeHours * 1.8))
                return
            case .ExtremelyActive:
                userSettings.calories = addSurplus(number: Int(normalHours + activeHours * 2))
                return
            }
        }
    }
    
    func addSurplus(number: Int) -> Int {
        switch userSettings.goal {
        case .LoseFast:
            return number - 500
        case .Lose:
            return number - 250
        case .Maintain:
            return number
        case .Gain:
            return number + 250
        case .GainFast:
            return number + 500
        }
    }
    
    func saveUserSettings() {
        UserDefaults.standard.set(true, forKey: "userSettingsSaved")
        UserDefaults.standard.set(userSettings.gender.rawValue, forKey: "gender")
        UserDefaults.standard.set(userSettings.birthday.ISO8601Format(), forKey: "birthday")
        UserDefaults.standard.set(userSettings.height, forKey: "height")
        UserDefaults.standard.set(userSettings.weight, forKey: "weight")
        UserDefaults.standard.set(userSettings.activityLevel.rawValue, forKey: "activityLevel")
        UserDefaults.standard.set(userSettings.goal.rawValue, forKey: "goal")
        UserDefaults.standard.set(userSettings.calories, forKey: "calories")
    }
    func getUserSettings() {
        userSettings = UserSettings(
            gender: Gender(rawValue: UserDefaults.standard.string(forKey: "gender") ?? Gender.Male.rawValue) ?? Gender.Male,
            birthday: ISO8601DateFormatter().date(from: UserDefaults.standard.string(forKey: "birthday") ?? Date().ISO8601Format()) ?? Date(),
            height: UserDefaults.standard.integer(forKey: "height") == 0 ? 160 : UserDefaults.standard.integer(forKey: "height"),
            weight: UserDefaults.standard.integer(forKey: "weight") == 0 ? 70 : UserDefaults.standard.integer(forKey: "weight"),
            activityLevel: ActivityLevel(rawValue: UserDefaults.standard.string(forKey: "activityLevel") ?? ActivityLevel.ModeratelyActive.rawValue) ?? ActivityLevel.ModeratelyActive,
            goal: Goal(rawValue: UserDefaults.standard.string(forKey: "goal") ?? Goal.Maintain.rawValue) ?? Goal.Maintain,
            calories: UserDefaults.standard.integer(forKey: "calories") == 0 ? 2000 : UserDefaults.standard.integer(forKey: "calories")
        )
    }
    
    func incActivityLevel() {
        switch userSettings.activityLevel {
        case .LightlyActive:
            userSettings.activityLevel = .ModeratelyActive
            break
        case .ModeratelyActive:
            userSettings.activityLevel = .VeryActive
            break
        case .VeryActive:
            userSettings.activityLevel = .ExtremelyActive
            break
        case .ExtremelyActive:
            break
        }
    }
    func decActivityLevel() {
        switch userSettings.activityLevel {
        case .LightlyActive:
            break
        case .ModeratelyActive:
            userSettings.activityLevel = .LightlyActive
            break
        case .VeryActive:
            userSettings.activityLevel = .ModeratelyActive
            break
        case .ExtremelyActive:
            userSettings.activityLevel = .VeryActive
        }
    }
    
    func incGoal() {
        switch userSettings.goal {
        case .LoseFast:
            userSettings.goal = .Lose
            break
        case .Lose:
            userSettings.goal = .Maintain
            break
        case .Maintain:
            userSettings.goal = .Gain
            break
        case .Gain:
            userSettings.goal = .GainFast
            break
        case .GainFast:
            break
        }
    }
    func decGoal() {
        switch userSettings.goal {
        case .LoseFast:
            break
        case .Lose:
            userSettings.goal = .LoseFast
            break
        case .Maintain:
            userSettings.goal = .Lose
            break
        case .Gain:
            userSettings.goal = .Maintain
            break
        case .GainFast:
            userSettings.goal = .Gain
            break
        }
    }
}

#Preview {
    RootView()
}
