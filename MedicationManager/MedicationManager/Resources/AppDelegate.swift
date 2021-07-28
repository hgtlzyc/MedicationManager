//
//  AppDelegate.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/20/20.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { authorized, error in
            
            if let error = error {
                print("There was an error requesting auth to use notification, \(error) ")
            }
            
            if authorized {
                UNUserNotificationCenter.current().delegate = self
                self.setnotificationCategories()
            } else {
                
            }
            
        }
        
        return true
    }
    
    // MARK: - Notification Categories
    private func setnotificationCategories() {
        let markTakenAction = UNNotificationAction(
            identifier: StringConstants.markTakenNotificationActionIdentifier,
            title: StringConstants.accept,
            options: UNNotificationActionOptions.foreground
        )
        
        let ignoreAction = UNNotificationAction(
            identifier: StringConstants.ignoreNotificationActionIdentifier,
            title: StringConstants.ignore,
            options: UNNotificationActionOptions(rawValue: 0)
        )
        
        let medicationActionsCategory = UNNotificationCategory(
            identifier: StringConstants.notificationCategoryIdentifier,
            actions: [markTakenAction, ignoreAction],
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "",
            options: .customDismissAction
        )
        
        UNUserNotificationCenter.current().setNotificationCategories([medicationActionsCategory])
        
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}//End Of Delegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        NotificationCenter.default.post(name: Notification.Name(StringConstants.reminderReceivedNotificationName),
            object: nil)
        completionHandler([.sound, .banner])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == StringConstants.markTakenNotificationActionIdentifier,
           let medicationID = response.notification.request.content.userInfo[StringConstants.medicationID] as? String {
            MedicationController.shared
            completionHandler()
        }
    }
    
    
}//End Of extension

