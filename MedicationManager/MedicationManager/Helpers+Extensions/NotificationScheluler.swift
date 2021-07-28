//
//  NotificationScheluler.swift
//  MedicationManager
//
//  Created by lijia xu on 7/28/21.
//

import UserNotifications

class NotificationScheluler {
    
    func scheduleNotification(for medication: Medication) {
        guard let timeOfDay = medication.timeOfDay,
              let identifer = medication.id?.uuidString else { return }
        
        clearNotification(for: medication)
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "it is time to \(medication.name ?? StringConstants.medication)"
        content.sound = .default
        content.userInfo = [StringConstants.medicationID : identifer]
        content.categoryIdentifier = StringConstants.medicationReminderCategoryIdentifier
        
        let fireDateComponents = Calendar.current.dateComponents([.hour, .minute], from: timeOfDay)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifer, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add( request ) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func clearNotification(for medication: Medication) {
        guard let identifer = medication.id?.uuidString else { return }
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifer])
    }
    
}//End Of class
