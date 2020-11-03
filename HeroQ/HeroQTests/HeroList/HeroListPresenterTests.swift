//
//  HeroListPresenterTests.swift
//  HeroQTests
//
//  Created by Tony Hadisiswanto on 02/11/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import XCTest
import SwiftyVIPER
import RxCocoa
@testable import HeroQ

class HeroListPresenterTests: XCTestCase {
    
    var router: MockHeroListRouter?
    var interactor: HeroListInteractor?
    var presenter: HeroListPresenter?
    
    let stubHero = Hero(id: 1, localizedName: "Anti-Mage", attackType: "Melee", roles: ["Carry", "Escape", "Nuker"], baseAttackMin: 29, baseAttackMax: 33, baseArmor: -1, moveSpeed: 310, baseHealth: 200, baseMana: 75, primaryAttr: "agi", img: "/apps/dota2/images/heroes/antimage_full.png?")
    
    var stubRoles: [RoleFilter] = []

    override func setUp() {
        router = MockHeroListRouter()
        interactor = HeroListInteractor()
        if let aRouter = router, let aInteractor = interactor {
            presenter = HeroListPresenter(router: aRouter, interactor: aInteractor)
            interactor?.presenter = presenter
            
            if let aPresenter = presenter {
                let view = HeroListViewController(presenter: aPresenter)
                presenter?.view = view
            }
        }
        
        let all = RoleFilter(id: 0, name: "All", isSelected: true)
        let carry = RoleFilter(id: 1, name: "Carry", isSelected: false)
        let escape = RoleFilter(id: 2, name: "Escape", isSelected: false)
        stubRoles = [all, carry, escape]
        
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testShowNoInternetAlert() {
        let isConnectedToInternet = !NetworkManager.shared.isConnectedToInternet()
        if isConnectedToInternet == false {
            presenter?.showNoInternetAlert()
            XCTAssertFalse(!NetworkManager.shared.isConnectedToInternet())
        }
    }
    
    func testGoToHeroDetail() {
        presenter?.goToHeroDetail(hero: stubHero, similarHeroes: [])
        XCTAssertTrue(router?.isGoToHeroDetailCalled ?? false)
    }
    
    func testGoToFilter() {
        presenter?.goToFilter(stubRoles)
        XCTAssertTrue(router?.isGoToFilterCalled ?? false)
    }
    
    func testGetSimilarHeroes() throws {
        let heroes = try MockHeroes.shared.getMockHeroesResponse()
        interactor?.obsHeroes.accept(heroes)
        
        let hero = try MockHeroes.shared.getMockHero() ?? stubHero
        let similarHeroes = presenter?.getSimilarHeroes(hero)
        guard let result = similarHeroes else { return }
        XCTAssertTrue(result.count <= 3, "should be 3 maximum similar heroes")
        
        for aHero in result {
            XCTAssertEqual(aHero.primaryAttr, hero.primaryAttr)
            XCTAssertTrue(aHero.roles.contains(hero.roles.first ?? ""))
        }
        
        var remainingHeroes = heroes.filter {
            $0.id != hero.id &&
            $0.primaryAttr == hero.primaryAttr &&
            $0.roles.contains(hero.roles.first ?? "")
        }
        if hero.primaryAttr == "agi" {
            remainingHeroes.sort { $0.moveSpeed > $1.moveSpeed }
        }
        
        XCTAssertEqual(remainingHeroes[0].moveSpeed, result[0].moveSpeed)
        XCTAssertEqual(remainingHeroes[1].moveSpeed, result[1].moveSpeed)
        XCTAssertEqual(remainingHeroes[2].moveSpeed, result[2].moveSpeed)
        
        XCTAssertEqual(remainingHeroes[0].localizedName, "Juggernaut")
        XCTAssertEqual(remainingHeroes[1].localizedName, "Bloodseeker")
        XCTAssertEqual(remainingHeroes[2].localizedName, "Mirana")
    }
    
    func testGetRoles() throws {
        let heroes = try MockHeroes.shared.getMockHeroesResponse()
        interactor?.obsHeroes.accept(heroes)
        
        let roles = presenter?.getRoles()
        XCTAssertEqual(roles?.first?.name, "All")
    }
    
    func testFilterHeroes() throws {
        let heroes = try MockHeroes.shared.getMockHeroesResponse()
        interactor?.obsHeroes.accept(heroes)
        
        let activeFilters = stubRoles.filter { $0.isSelected == true }
        presenter?.filterHeroes(activeFilters)
        
        guard let filters = interactor?.obsActiveFilters.value else { return }
        for filter in filters {
            XCTAssertTrue(filter.isSelected)
        }
    }
}

extension HeroListPresenterTests {
    class MockHeroListRouter: HeroListPresenterRouterProtocol {
        var isGoToHeroDetailCalled = false
        var isGoToFilterCalled = false
        
        func present(_ view: UIViewController, completion: CodeBlock?) {}
        
        func dismiss(completion: CodeBlock?) {}
        
        @discardableResult
        func pop() -> UIViewController? {
            return UIViewController()
        }
        
        func goToHeroDetail(hero: Hero, similarHeroes: [Hero]) {
            isGoToHeroDetailCalled = true
        }
        
        func goToFilter(_ roles: [RoleFilter]) {
            isGoToFilterCalled = true
        }
    }
    
    class MockHeroListInteractor: HeroListPresenterInteractorProtocol {
        lazy var obsHeroes: BehaviorRelay<[Hero]> = BehaviorRelay(value: [])
        
        var isFetching: Driver<Bool> {
            return _isFetching.asDriver()
        }
        
        var error: Driver<String?> {
            return _error.asDriver()
        }
        
        var hasError: Bool {
            return _error.value != nil
        }
        
        private let _isFetching = BehaviorRelay<Bool>(value: false)
        private let _error = BehaviorRelay<String?>(value: nil)
        
        func requestTitle() {}
        
        func fetchHeroes() {}
        
        func getObsHeroes() -> BehaviorRelay<[Hero]> {
            return obsHeroes
        }
        
        func getFetchingState() -> Driver<Bool> {
            return isFetching
        }
        
        func getErrorState() -> Bool {
            return hasError
        }
        
        func getErrorInfo() -> Driver<String?> {
            return error
        }
        
        func getSimilarHeroes(_ hero: Hero) -> [Hero] {
            return []
        }
        
        func getRoles() -> [RoleFilter] {
            return []
        }
        
        func filterHeroes(_ filters: [RoleFilter]) {}
    }
}
