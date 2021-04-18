//
//  MainViewController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 16/04/2021.
//

import UIKit

class MainViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        self.navigationController?.navigationBar.barTintColor = kMC.Colors.main
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: kMC.Colors.Text.onMain]
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = kMC.Colors.Background.primary
    }
    
    /// Generate dynamic layout for collectionView
    public func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200))
        let fullArtistItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullArtistItem.edgeSpacing = .init(leading: nil, top: .fixed(3), trailing: nil, bottom: .fixed(3))
        
        var numberItemsPerRow: Int = 3
        // If iPad OR isLandcape orientation
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.orientation.isLandscape {
            numberItemsPerRow = 5
            
            // If iPad + compacted horizontal class (means using 2 apps at the same time on iPad)
            if UIDevice.current.userInterfaceIdiom == .pad && self.traitCollection.horizontalSizeClass == .compact {
                numberItemsPerRow = 3
            }
        }
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: fullArtistItem, count: numberItemsPerRow)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let footerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerItemSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        section.boundarySupplementaryItems = [footerItem]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
