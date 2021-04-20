//
//  ArtistDetailsPageViewController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import UIKit

class ArtistDetailsPageViewController: UIPageViewController {
    
    // MARK: - Properties
    
    var viewModel: ArtistsViewModel!
    var openedIndex: Int = 0 {
        didSet {
            self.currentItemIndex = self.openedIndex
        }
    }
    
    var currentItemIndex: Int!
    
    private lazy var detailViewControllers: [UIViewController] = .init()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        self.setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        self.setBookmarkNavigationItem(for: self.currentItemIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Debug a glitch that occurs on pushVC because of searchBar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        self.view.backgroundColor = kMC.Colors.Background.primary
        
        if let viewModel = self.viewModel {
            for (index, artist) in viewModel.artists.enumerated() {
                let vc: ArtistDetailsViewController = .init()
                vc.artistDetailsViewModel = .init(artist: artist)
                vc.pageIndex = index
                self.detailViewControllers.append(vc)
            }
        }
        
        if openedIndex >= 0 && openedIndex < detailViewControllers.count {
            self.setViewControllers([detailViewControllers[openedIndex]], direction: .forward, animated: false, completion: nil)
        }
    }
    
    private func setBookmarkNavigationItem(for index: Int) {
        self.currentItemIndex = index
        
        guard let vcs = self.detailViewControllers as? [ArtistDetailsViewController], index < vcs.count else {
            return
        }
        let vc = vcs[index]
        
        var bookmarkImage = UIImage(systemName: kMC.Images.bookmark)
        if vc.artistDetailsViewModel.isArtistBookmarked() {
            bookmarkImage = UIImage(systemName: kMC.Images.bookmarkFill)
        }
        
        self.navigationItem.rightBarButtonItem = .init(image: bookmarkImage, style: .plain, target: self, action: #selector(bookmarkAction))
    }
    
    // MARK: - Methods
    
    @objc func bookmarkAction() {
        guard let vcs = self.detailViewControllers as? [ArtistDetailsViewController], self.currentItemIndex < vcs.count else {
            return
        }
        let vc = vcs[self.currentItemIndex]
        
        vc.artistDetailsViewModel.bookmarkAction()
        
        self.setBookmarkNavigationItem(for: self.currentItemIndex)
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


// MARK: - PageViewController delegate


extension ArtistDetailsPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            guard let vc = pageViewController.viewControllers?[0] as? ArtistDetailsViewController else {
                return
            }
            
            self.setBookmarkNavigationItem(for: vc.pageIndex)
        }
    }
}
