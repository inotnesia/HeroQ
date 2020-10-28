//
//  HeroDetailViewController.swift
//  Project: HeroQ
//
//  Module: HeroDetail
//
//  Created by Tony Hadisiswanto on 27/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import SwiftyVIPER
import RxCocoa
import RxSwift

// MARK: Protocols
protocol HeroDetailPresenterViewProtocol: class {
    // HeroDetail Presenter to View Protocol
    func set(title: String?)
    func performUpdates(animated: Bool)
}

// MARK: -

/// The View Controller for the HeroDetail module
class HeroDetailViewController: UIViewController {
    
    // MARK: - Constants
    let presenter: HeroDetailViewPresenterProtocol
    private let _disposeBag = DisposeBag()
    
    // MARK: Variables
    private var _obsHero: BehaviorRelay<Hero>?
    private var _obsHeroes: BehaviorRelay<[Hero]>?
    
    lazy var adapter: HeroDetailAdapter = {
        let aAdapter = HeroDetailAdapter(viewController: self)
        return aAdapter
    }()
    
    lazy var collectionView: UICollectionView = {
        return UICollectionView.createView(with: .white)
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    // MARK: Outlets
    
    // MARK: Inits
    init(presenter: HeroDetailViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _obsHero = presenter.getObsHero()
        adapter.obsHero = _obsHero
        
        _obsHeroes = presenter.getObsHeroes()
        adapter.obsHeroes = _obsHeroes
        
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
        collectionView.constrainEdges(to: view)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        view.setNeedsUpdateConstraints()
        
        setupNavBar()
        setupBackButton()
    }
}

extension HeroDetailViewController: HeroDetailPresenterViewProtocol {
    
    // MARK: - HeroDetail Presenter to View Protocol
    func set(title: String?) {
        self.title = title
    }
    
    func performUpdates(animated: Bool) {
        adapter.setupListDiffable()
        adapter.performUpdates(animated: animated, completion: nil)
    }
}
