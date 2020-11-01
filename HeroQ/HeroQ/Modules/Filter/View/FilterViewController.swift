//
//  FilterViewController.swift
//  Project: HeroQ
//
//  Module: Filter
//
//  Created by Tony Hadisiswanto on 28/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

// MARK: Imports
import UIKit
import SwiftyVIPER
import RxCocoa
import RxSwift

// MARK: Protocols
protocol FilterPresenterViewProtocol: class {
    // Filter Presenter to View Protocol
    func set(title: String?)
    func performUpdates(animated: Bool)
}

protocol FilterModuleProtocol: class {
    func didSaveButtonTapped(_ filters: [RoleFilter])
}

// MARK: -

/// The View Controller for the Filter module
class FilterViewController: UIViewController {
    
    // MARK: - Constants
    let presenter: FilterViewPresenterProtocol
    let disposeBag = DisposeBag()
    
    // MARK: Variables
    private var _obsRoles: BehaviorRelay<[RoleFilter]>?
    weak var delegate: FilterModuleProtocol?
    
    lazy var adapter: FilterAdapter = {
        let aAdapter = FilterAdapter(viewController: self)
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
    init(presenter: FilterViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _obsRoles = presenter.getObsRoles()
        adapter.obsRoles = _obsRoles
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        
        _setupView()
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
    private func _setupView() {
        collectionView.constrainEdges(to: view)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        view.setNeedsUpdateConstraints()
        
        setupNavBar()
        setupBackButton()
        _setupCloseButton()
        _setupSaveButton()
    }
    
    private func _setupCloseButton() {
        let button = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(_closeButtonTapped(sender:)))
        button.tintColor = .white
        navigationItem.setLeftBarButton(button, animated: true)
    }
    
    private func _setupSaveButton() {
        let button = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(_saveButtonTapped(sender:)))
        button.tintColor = .white
        navigationItem.setRightBarButton(button, animated: true)
    }
    
    // MARK: Outlet Action
    @objc private func _closeButtonTapped(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func _saveButtonTapped(sender: UIBarButtonItem) {        
        let selectedFilters = presenter.getSelectedFilters()
        if selectedFilters.count > 0 {
            delegate?.didSaveButtonTapped(selectedFilters)
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Hello...", message: "You haven't selected a filter.\nPlease select one filter at least", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension FilterViewController: FilterPresenterViewProtocol {
    
    // MARK: - Filter Presenter to View Protocol
    func set(title: String?) {
        self.title = title
    }
    
    func performUpdates(animated: Bool) {
        adapter.setupListDiffable()
        adapter.performUpdates(animated: animated, completion: nil)
    }
}

extension FilterViewController: FilterProtocol {
    func didRoleButtonTapped(index: Int, isSelected: Bool) {
        presenter.didRoleButtonTapped(index: index, isSelected: isSelected)
    }
}
