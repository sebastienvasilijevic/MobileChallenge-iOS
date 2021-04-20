//
//  AppDelegate.swift
//  MobileChallenge
//
//  Created by Taras on 10/03/2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var tabBarController: UITabBarController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.setupUI()
        
        return true
    }

    // MARK: Setup UI

    private func setupUI() {
        (UITabBar.appearance()).unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)
        (UITabBar.appearance()).tintColor = .white
        (UITabBar.appearance()).barTintColor = kMC.Colors.main
        (UITabBar.appearance()).isTranslucent = false
        
        let artistsListVC: ArtistsViewController = .init()
        let artistsListNavController: MainNavigationController = .init(rootViewController: artistsListVC)
        
        let bookmarksVC: BookmarksViewController = .init()
        let bookmarksNavController: MainNavigationController = .init(rootViewController: bookmarksVC)
        
        self.tabBarController = .init()
        self.tabBarController.setViewControllers([artistsListNavController, bookmarksNavController], animated: false)
        
        let normalSearchImage = UIImage(systemName: kMC.Images.magnifyingglass, withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        let selectedSearchImage = UIImage(systemName: kMC.Images.magnifyingglass, withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        artistsListNavController.tabBarItem = .init(title: "tabBar_search_artists_label".localized, image: normalSearchImage, selectedImage: selectedSearchImage)
        
        let normalBookmarkImage = UIImage(systemName: kMC.Images.bookmark, withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        let selectedBookmarkImage = UIImage(systemName: kMC.Images.bookmarkFill, withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        bookmarksNavController.tabBarItem = .init(title: "tabBar_bookmarks_label".localized, image: normalBookmarkImage, selectedImage: selectedBookmarkImage)
        
        self.window?.rootViewController = self.tabBarController
        
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: - Utils methods
    
    func presentFirstTab() {
        self.tabBarController.selectedIndex = 0
    }
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MobileChallenge")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Handle error
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Handle error
            }
        }
    }
}
