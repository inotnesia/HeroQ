//
//  HeroListInteractorTests.swift
//  HeroQTests
//
//  Created by Tony Hadisiswanto on 03/11/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import XCTest
import SwiftyVIPER
import RxCocoa
@testable import HeroQ

class HeroListInteractorTests: XCTestCase {
    
    var interactor: HeroListInteractor?
    var presenter: HeroListPresenter?
    
    var mockHeroService: MockHeroServiceProtocol?
    private let _error = BehaviorRelay<String?>(value: nil)
    private var _masterHeroes: [Hero] = []

    override func setUp() {
        mockHeroService = MockHeroServiceProtocol()
        interactor = HeroListInteractor()
        guard let aInteractor = interactor else { return }
        presenter = HeroListPresenter(router: HeroListRouter(), interactor: aInteractor)
        if let aPresenter = presenter {
            let view = HeroListViewController(presenter: aPresenter)
            presenter?.view = view
        }
        interactor?.presenter = presenter
        
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchHeroes() {
        if NetworkManager.shared.isConnectedToInternet() {
            mockHeroService?.fetchHeroes(successHandler: { [weak self] (response) in
                self?.interactor?.obsHeroes.accept(response)
            }) { [weak self] (error) in
                self?._error.accept(error.localizedDescription)
            }
        } else {
            interactor?.presenter?.showNoInternetAlert()
        }
        XCTAssertTrue(mockHeroService?.isFetchHeroesInvoked ?? false)
    }
}
