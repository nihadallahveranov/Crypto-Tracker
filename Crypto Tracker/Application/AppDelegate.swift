//
//  AppDelegate.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 06.07.23.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let bgTaskIdentifier = "com.Crypto-Tracker.backgroundTask"

        // Register the background task handler
        BGTaskScheduler.shared.register(forTaskWithIdentifier: bgTaskIdentifier, using: nil) { task in
            self.handleBackgroundTask(task: task as! BGAppRefreshTask)
        }
        // Override point for customization after application launch.
        return true
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
    
    func handleBackgroundTask(task: BGAppRefreshTask) {
        guard UIApplication.shared.connectedScenes.first is UIWindowScene else {
            task.setTaskCompleted(success: false)
            return
        }

        let backgroundTaskManager = BackgroundTaskManager.shared
        backgroundTaskManager.handleBackgroundTask(task: task)

        // Set the task completed handler
        task.expirationHandler = {
            backgroundTaskManager.scheduleBackgroundTask()
        }

        // Inform the system that the background task is complete
        task.setTaskCompleted(success: true)
    }


}

