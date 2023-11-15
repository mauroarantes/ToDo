//
//  ToDoTests.swift
//  ToDoTests
//
//  Created by Mauro Arantes on 14/11/2023.
//

import XCTest
@testable import ToDo

class ToDoTests: XCTestCase {
    
    var sut: ToDoListViewModel?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testApiCall_isSuccess() {
        //given
        sut = ToDoListViewModel(apiService: MockAPIService(fileName: "MockResponse"))
        //when
        sut?.getList()
        //then
        XCTAssertEqual(sut?.toDoList.count, 116)
    }
    
    func testApiCall_isFailure() {
        let expetation = XCTestExpectation(description: "Fetching Products list")
        let waitDuration = 3.0
        sut = ToDoListViewModel(apiService: MockAPIService(fileName: "Error"))
        sut?.getList()
        DispatchQueue.main.asyncAfter(deadline: .now() + waitDuration){
            XCTAssertEqual(self.sut?.toDoList.count, 0)
            XCTAssertEqual(self.sut?.customError, NetworkError.dataNotFound)
            expetation.fulfill()
        }
        wait(for: [expetation], timeout: waitDuration)
    }
}
