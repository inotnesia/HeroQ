//
//  FilterCollectionViewCell.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 28/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    var view: FilterProtocol?
    var identifier: FilterIdentifier? {
        didSet {
            _setupView()
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func _setupView() {
        titleLabel.text = "Roles"
        titleLabel.textColor = .heroQPrimaryColor
        _setupCollectionView()
        layoutIfNeeded()
    }
    
    private func _setupCollectionView() {
        let layout = UICollectionViewCenterLayout()
        layout.estimatedItemSize = CGSize(width: 130, height: 30)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: ButtonCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ButtonCollectionViewCell.self))
    }
}

extension FilterCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return identifier?.obsRoles?.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ButtonCollectionViewCell.self), for: indexPath) as? ButtonCollectionViewCell else { return UICollectionViewCell() }
        if let items = identifier?.obsRoles?.value, items.count > indexPath.row {
            cell.view = view
            cell.setupView(index: indexPath.row, title: items[indexPath.row].name, isSelected: items[indexPath.row].isSelected)
        }
        return cell
    }
}
