//
//  SceneDelegate.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 20/04/2021.
//

import SnapKit
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var tabBarController: UITabBarController!
    var splitViewController: MainSplitViewController!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
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
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    
    // MARK: Setup UI
    
    /// Create artists ViewController embedded into our MainNavigationController (to get all default configuration)
    func createArtistsNavigationController() -> MainNavigationController {
        // we create the view controller and insert into the nav controller and return
        let vc: ArtistsViewController = .init()
        
        let normalSearchImage = UIImage(systemName: kMC.Images.magnifyingglass, withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        let selectedSearchImage = UIImage(systemName: kMC.Images.magnifyingglass, withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        vc.tabBarItem = .init(title: "tabBar_search_artists_label".localized, image: normalSearchImage, selectedImage: selectedSearchImage)
        vc.tabBarItem.tag = 0
        
        return .init(rootViewController: vc)
    }

    /// Create bookmarks ViewController embedded into our MainNavigationController (to get all default configuration)
    func createBookmarksNavigationController() -> MainNavigationController {
        let vc: BookmarksViewController = .init()
        
        let normalBookmarkImage = UIImage(systemName: kMC.Images.bookmark, withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        let selectedBookmarkImage = UIImage(systemName: kMC.Images.bookmarkFill, withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        vc.tabBarItem = .init(title: "tabBar_bookmarks_label".localized, image: normalBookmarkImage, selectedImage: selectedBookmarkImage)
        vc.tabBarItem.tag = 1
        
        return .init(rootViewController: vc)
    }
    
    /// Create a placeholder for the detailsView of the SplitViewController (when no artist is selected)
    func createPlaceholderDetails() -> MainViewController {
        let vc: ArtistDetailsPlaceholderViewController = .init()
        return vc
    }
    
    func createTabBar() -> MainSplitViewController {
        tabBarController = UITabBarController()
        // here we assign a tint to all our tabbars, this will be visible on the items (icons)
        (UITabBar.appearance()).unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)
        (UITabBar.appearance()).tintColor = .white
        (UITabBar.appearance()).barTintColor = kMC.Colors.main
        (UITabBar.appearance()).isTranslucent = false
        // replace our array variables with the functions we created
        tabBarController.viewControllers = [createArtistsNavigationController(), createBookmarksNavigationController()]
        
        splitViewController = MainSplitViewController()
        splitViewController.preferredDisplayMode = .oneBesideSecondary
        splitViewController.viewControllers = [tabBarController, createPlaceholderDetails()]
        
        return splitViewController
    }
    
    // MARK: - Utils methods
    
    func presentFirstTab() {
        self.tabBarController?.selectedIndex = 0
    }
    
    func showDetailsMode() {
        splitViewController.preferredDisplayMode = .oneBesideSecondary
    }
}
