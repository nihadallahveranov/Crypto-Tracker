//
//  SceneDelegate.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 06.07.23.
//

import UIKit
import BackgroundTasks
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var timer: Timer?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // background taks identifier
        let bgTaskIdentifier = "com.Crypto-Tracker.backgroundTask"

        // Register the background task handler
        BGTaskScheduler.shared.register(forTaskWithIdentifier: bgTaskIdentifier, using: nil) { task in
            self.handleBackgroundTask(task: task as! BGAppRefreshTask)
        }
        
        // check notification permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
        UNUserNotificationCenter.current().delegate = self
        
        // Schedule the API call to run every minute in foreground
        timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(apiCall), userInfo: nil, repeats: true)
        
        window = UIWindow(windowScene: windowScene)
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .dark
        }
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        window?.makeKeyAndVisible()
        
        // resetting notifications
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        // Invalidate the timer when the app enters the foreground
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
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
    
    @objc
    func apiCall() {
        // Perform your API call here
        ForegroundTaskManager.shared.fetchCoinRates { coinRates in
            DispatchQueue.main.async {
                ForegroundTaskManager.shared.performForeground()
            }

        }
    }
}

