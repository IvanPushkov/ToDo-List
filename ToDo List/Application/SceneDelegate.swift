//
//  SceneDelegate.swift
//  ToDo List
//
//  Created by Ivan Pushkov on 22.11.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController!
    var tabBarForEdit: UITabBarController!
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        if isFirstLounch(){
            showLoadingScreen()
            loadTaskFromAPI()
        } else {
            showMainScreen()
        }
    }
       private func isFirstLounch() -> Bool{
            let userDefaults = UserDefaults.standard
            let firstLounchKey = "FirstLounch"
            if userDefaults.bool(forKey: firstLounchKey){
                return false
            } else {
                userDefaults.setValue(true, forKey: firstLounchKey)
                return true
            }
        }
       
    private func showLoadingScreen() {
        let loadingVC = LoadingViewController()
        window?.rootViewController = loadingVC
        window?.makeKeyAndVisible()
    }
   
    private func loadTaskFromAPI(){
        TaskManager.shared.loadTasks{ [weak self] in
            self?.showMainScreen()
        }
    }
    
    private func  showMainScreen(){
        let rootVC =  ToDoListBuilder.build()
         tabBarForEdit = CustomTabBar()
        tabBarForEdit.viewControllers = [rootVC]
        navigationController = UINavigationController(rootViewController: tabBarForEdit)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
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
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

