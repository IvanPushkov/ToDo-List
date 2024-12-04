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
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
     
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataStack.shared.saveContext()
    }


}

