//
//  HeroListViewController.swift
//  Project: HeroQ
//
//  Module: HeroList
//
//  Created by Tony Hadisiswanto on 26/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import SwiftyVIPER
import RxSwift

// MARK: Protocols
protocol HeroListPresenterViewProtocol: class {
    // HeroList Presenter to View Protocol
    func set(title: String?)
}

// MARK: -

/// The View Controller for the HeroList module
class HeroListViewController: UIViewController {
    
    // MARK: - Constants
    let presenter: HeroListViewPresenterProtocol
    let disposeBag = DisposeBag()
    
    // MARK: Variables
    
    lazy var adapter: HeroListAdapter = {
        let aAdapter = HeroListAdapter(viewController: self)
        return aAdapter
    }()
    
    lazy var collectionView: UICollectionView = {
        return UICollectionView.createView(with: .heroQBgColor)
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    // MARK: Outlets
    
    // MARK: Inits
    init(presenter: HeroListViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        
        setupView()
        presenter.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Custom Functions
    func setupView() {
        // Setup View
        collectionView.constrainEdges(to: view)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        view.setNeedsUpdateConstraints()
        
        setupNavBar()
        setupBackButton()
        _setupFilterButton()
//        setupActivityIndicator()
//        setupInfoLabel()
    }
    
    private func _setupFilterButton() {
        let button = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(_filterButtonTapped(sender:)))
        button.tintColor = .white
        navigationItem.setLeftBarButton(button, animated: true)
    }
    
    // MARK: Outlet Action
    @objc private func _filterButtonTapped(sender: UIBarButtonItem) {
        print("## show filter")
//        let categoryView = CategoryView(frame: UIScreen.main.bounds)
//        if let categories = obsCategories {
//            categoryView.setupView(categories)
//        }
//
//        categoryView.delegate = self
//        categoryView.show(animated: true, alpha: 0.66)
    }
}

extension HeroListViewController: HeroListPresenterViewProtocol {
    
    // MARK: - HeroList Presenter to View Protocol
    func set(title: String?) {
        self.title = title
    }
}
