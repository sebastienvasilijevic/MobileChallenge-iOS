//
//  ArtistDetailsPageViewController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import UIKit

class ArtistDetailsPageViewController: UIPageViewController {

    var openedIndex: Int = 0
    var data: [Artist] = []
    
    private lazy var detailViewControllers: [UIViewController] = {
        var v: [UIViewController] = .init()
        for (index, artist) in self.data.enumerated() {
            let detailViewController: ArtistDetailsViewController = .init()
            detailViewController.data = artist
            detailViewController.pageIndex = index
            v.append(detailViewController)
        }
        return v
    }()
    
    override func loadView() {
        super.loadView()
        
        self.setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        if openedIndex >= 0 && openedIndex < detailViewControllers.count {
            self.setViewControllers([detailViewControllers[openedIndex]], direction: .forward, animated: false, completion: nil)
        }
    }
}


// MARK: - PageViewController dataSource

extension ArtistDetailsPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? ArtistDetailsViewController else {
            return nil
        }
        var index = vc.pageIndex
        if index == 0 || index == NSNotFound {
            return nil
        }
        index! -= 1
        return detailViewControllers[index!]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? ArtistDetailsViewController else {
            return nil
        }
        var index = vc.pageIndex
        if index == detailViewControllers.count-1 || index == NSNotFound {
            return nil
        }
        index! += 1
        return detailViewControllers[index!]
    }
}
