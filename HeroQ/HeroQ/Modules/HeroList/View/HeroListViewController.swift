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
import RxCocoa
import RxSwift

// MARK: Protocols
protocol HeroListPresenterViewProtocol: class {
    // HeroList Presenter to View Protocol
    func set(title: String?)
    func performUpdates(animated: Bool)
}

// MARK: -

/// The View Controller for the HeroList module
class HeroListViewController: UIViewController {
    
    // MARK: - Constants
    let presenter: HeroListViewPresenterProtocol
    private let _disposeBag = DisposeBag()
    
    // MARK: Variables
    private var _obsHeroes: BehaviorRelay<[Hero]>?
    
    lazy var adapter: HeroListAdapter = {
        let aAdapter = HeroListAdapter(viewController: self)
        return aAdapter
    }()
    
    lazy var collectionView: UICollectionView = {
        return UICollectionView.createView(with: .heroQBgColor)
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width - 32, height: 40))
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.center = view.center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
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
        
        _obsHeroes = presenter.getObsHeroes()
        adapter.obsHeroes = _obsHeroes
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        
        view.addSubview(activityIndicator)
        view.addSubview(infoLabel)
        
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
        collectionView.constrainEdges(to: view)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        view.setNeedsUpdateConstraints()
        
        setupNavBar()
        setupBackButton()
        _setupFilterButton()
        _setupActivityIndicator()
        _setupInfoLabel()
    }
    
    private func _setupFilterButton() {
        let button = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(_filterButtonTapped(sender:)))
        button.tintColor = .white
        navigationItem.setLeftBarButton(button, animated: true)
    }
    
    private func _setupActivityIndicator() {
        presenter.getFetchingState().drive(activityIndicator.rx.isAnimating).disposed(by: _disposeBag)
    }
    
    private func _setupInfoLabel() {
        presenter.getErrorInfo().drive(onNext: {[unowned self] (error) in
            self.infoLabel.isHidden = !self.presenter.getErrorState()
            self.infoLabel.text = error
        }).disposed(by: _disposeBag)
    }
    
    // MARK: Outlet Action
    @objc private func _filterButtonTapped(sender: UIBarButtonItem) {
        //TODO: Implement filter here
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
    
    func performUpdates(animated: Bool) {
        adapter.setupListDiffable()
        adapter.performUpdates(animated: animated, completion: nil)
    }
}

extension HeroListViewController: GridProtocol {
    
    // MARK: - GridProtocol
    func didHeroTapped(_ hero: Hero) {
        let heroes = presenter.getSimilarHeroes(hero)
        presenter.goToHeroDetail(hero: hero, similarHeroes: heroes)
    }
}
