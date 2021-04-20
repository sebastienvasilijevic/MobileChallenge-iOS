//
//  MCTagsView.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 20/04/2021.
//

import SnapKit
import UIKit

class MCTagsView: UIView {
    
    struct MCTag {
        var text: String = ""
    }
    
    private(set) lazy var tagsArray: [MCTag] = []
    
    private lazy var tagsCollectionView: MCTagCollectionView = {
        let layout: MCTagCollectionViewFlowLayout = .init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = kMC.UI.margins/2
        layout.minimumInteritemSpacing = kMC.UI.margins/2
        layout.scrollDirection = .vertical
        let v: MCTagCollectionView = .init(frame: .zero, collectionViewLayout: layout)
        v.backgroundColor = .clear
        v.isScrollEnabled = false
        v.delegate = self
        v.dataSource = self
        v.register(MCTagCollectionViewCell.self, forCellWithReuseIdentifier: MCTagCollectionViewCell.identifier)
        v.isDynamicSizeRequired = true
        return v
    }()
    
    public var isRounded: Bool = false {
        didSet {
            self.reloadData()
        }
    }
    public var tagHeight: CGFloat = 0
    public var tagFont: UIFont = kMC.Font.regular.withSize(kMC.Font.defaultSize-2)
    
    public var contentSize: CGSize {
        self.tagsCollectionView.reloadData()
        return self.tagsCollectionView.collectionViewLayout.collectionViewContentSize
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        
        addSubview(tagsCollectionView)
        
        tagsCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        deleteAllTags()
    }
    
    public func addTag(_ text: String) {
        let tag: MCTag = .init(text: text)
        self.addTag(tag)
    }
    
    public func addTag(_ tag: MCTag) {
        self.addTags([tag])
    }
    
    public func addTags(_ tags: [MCTag]) {
        self.tagsArray.append(contentsOf: tags)
        self.reloadData()
    }
    
    public func deleteAllTags() {
        self.tagsArray.removeAll()
        self.reloadData()
    }
    
    public func reloadData() {
        self.tagsCollectionView.reloadData()
    }
    
    public func isEmpty() -> Bool {
        return self.tagsArray.isEmpty
    }
    
    public var count: Int {
        return self.tagsArray.count
    }
}


// MARK: - CollectionView delegate & dataSource & delegateFlowLayout

extension MCTagsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.tagsCollectionView.dequeueReusableCell(withReuseIdentifier: MCTagCollectionViewCell.identifier, for: indexPath) as? MCTagCollectionViewCell else { return MCTagCollectionViewCell() }
        let item = indexPath.item
        let tag = self.tagsArray[item]
        
        cell.tagHeight = tagHeight
        cell.configure(withText: tag.text)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text: String = self.tagsArray[indexPath.item].text
        let cellWidth: CGFloat = (kMC.UI.margins/3) + (text.size(withAttributes: [.font: tagFont]).width) + (kMC.UI.margins/3) + (kMC.UI.margins/2)
        
        return CGSize(width: cellWidth, height: tagHeight)
    }
}
