//
//  SlackLogTests.swift
//  SlackLog
//
//  Created by Sergei Perevoznikov on 30/12/2016.
//
//

import XCTest
import Foundation
import Kitura
import KituraNet
import SwiftyJSON
import WebRequest

@testable import SlackLog

class SlackLogTests: XCTestCase {
    
    private var key: String?
    private var value: Any?
    
    override public func tearDown() {
        Kitura.stop()
        super.tearDown()
    }
    
    func testError() {
        error { _, _, code in
            XCTAssertTrue(code == 200)
        }
    }
    
    func testInfo() {
        info { _, _, success in
            XCTAssertTrue(success == 200)
        }
    }
    
    func testDebug() {
        debug { _, _, success in
            XCTAssertTrue(success == 200)
        }
    }
    
    func testWarning() {
        warning { _, _, success in
            XCTAssertTrue(success == 200)
        }
    }
    
    func testErrorAuthor() {
        let value = Random.string()
        Log.author = value
        key = "attachments"
        error(author: value) { _, _, _ in
            guard let array = self.value as? [[String: Any]] else {
                XCTFail("\(self.value)")
                return
            }
            XCTAssertEqual(array[0]["author_name"] as? String, value)
        }
    }
    
    func testInfoAuthor() {
        let value = Random.string()
        Log.author = value
        key = "attachments"
        info(author: value) { _, _, _ in
            guard let array = self.value as? [[String: Any]] else {
                XCTFail("\(self.value)")
                return
            }
            XCTAssertEqual(array[0]["author_name"] as? String, value)
        }
    }
    
    func testWarningAuthor() {
        let value = Random.string()
        Log.author = value
        key = "attachments"
        warning(author: value) { _, _, _ in
            guard let array = self.value as? [[String: Any]] else {
                XCTFail("\(self.value)")
                return
            }
            XCTAssertEqual(array[0]["author_name"] as? String, value)
        }
    }
    
    func testDebugAuthor() {
        let value = Random.string()
        Log.author = value
        key = "attachments"
        debug(author: value) { _, _, _ in
            guard let array = self.value as? [[String: Any]] else {
                XCTFail("\(self.value)")
                return
            }
            XCTAssertEqual(array[0]["author_name"] as? String, value)
        }
    }
    
    func testErrorUsername() {
        let value = Random.string()
        Log.username = value
        key = "username"
        error(username: value) { _, _, _ in
            XCTAssertEqual(self.value as? String, value)
        }
    }
    
    func testInfoUsername() {
        let value = Random.string()
        Log.username = value
        key = "username"
        info(username: value) { _, _, _ in
            XCTAssertEqual(self.value as? String, value)
        }
    }
    
    func testWarningUsername() {
        let value = Random.string()
        Log.username = value
        key = "username"
        warning(username: value) { _, _, _ in
            XCTAssertEqual(self.value as? String, value)
        }
    }
    
    func testDebugUsername() {
        let value = Random.string()
        Log.username = value
        key = "username"
        debug(username: value) { _, _, _ in
            XCTAssertEqual(self.value as? String, value)
        }
    }
    
    func testErrorText() {
        let value = Random.string()
        key = "attachments"
        error(value) { _, _, _ in
            guard let array = self.value as? [[String: Any]] else {
                XCTFail("\(self.value)")
                return
            }
            XCTAssertEqual(array[0]["text"] as? String, value)
        }
    }
    
    func testWarningText() {
        let value = Random.string()
        key = "attachments"
        warning(value) { _, _, _ in
            guard let array = self.value as? [[String: Any]] else {
                XCTFail("\(self.value)")
                return
            }
            XCTAssertEqual(array[0]["text"] as? String, value)
        }
    }
    
    func testInfoText() {
        let value = Random.string()
        key = "attachments"
        info(value) { _, _, _ in
            guard let array = self.value as? [[String: Any]] else {
                XCTFail("\(self.value)")
                return
            }
            XCTAssertEqual(array[0]["text"] as? String, value)
        }
    }
    
    func testDebugText() {
        let value = Random.string()
        key = "attachments"
        debug(value) { _, _, _ in
            guard let array = self.value as? [[String: Any]] else {
                XCTFail("\(self.value)")
                return
            }
            XCTAssertEqual(array[0]["text"] as? String, value)
        }
    }
    
    public static var all : [(String, (SlackLogTests) -> () throws -> Void)] {
        return [
            //("testError", testError),
            //("testDebug", testDebug),
            //("testWarning", testWarning),
            //("testInfo", testInfo),
            
            //("testErrorAuthor", testErrorAuthor),
            ("testDebugAuthor", testDebugAuthor),
            ("testWarningAuthor", testWarningAuthor),
            ("testInfoAuthor", testInfoAuthor),
            
            ("testErrorUsername", testErrorUsername),
            //("testDebugUsername", testDebugUsername),
            ("testWarningUsername", testWarningUsername),
            ("testInfoUsername", testInfoUsername),
            
            ("testErrorText", testErrorText),
            ("testDebugText", testDebugText),
            //("testWarningText", testWarningText),
            ("testInfoText", testInfoText),
        ]
    }
    
    var log: Log!
    
    private func info(_ message: String = "info",
                      author: String = "sperev/slack",
                      username: String = "tests",
                      completion: @escaping (Any?, Swift.Error?, Int) -> Void) {
        mock() { exp, http, webhook in
            self.log = Log(webhookURL: webhook)
            self.log.level = .verbose
            self.log.username = username
            self.log.author.name = author
            self.log.info(message) { object, error, code in
                completion(object, error, code)
                http?.stop()
                exp.fulfill()
            }
        }
    }
    
    private func error(_ message: String = "error",
                       author: String = "sperev/slack",
                       username: String = "tests",
                       completion: @escaping (Any?, Swift.Error?, Int) -> Void) {
        mock() { exp, http, webhook in
            self.log = Log(webhookURL: webhook)
            self.log.level = .verbose
            self.log.username = username
            self.log.author.name = author
            self.log.error(message) { object, error, code in
                completion(object, error, code)
                http?.stop()
                exp.fulfill()
            }
        }
    }
    
    private func debug(_ message: String = "debug",
                       author: String = "sperev/slack",
                       username: String = "tests",
                       completion: @escaping (Any?, Swift.Error?, Int) -> Void) {
        mock() { exp, http, webhook in
            self.log = Log(webhookURL: webhook)
            self.log.level = .verbose
            self.log.username = username
            self.log.author.name = author
            self.log.debug(message) { object, error, code in
                completion(object, error, code)
                http?.stop()
                exp.fulfill()
            }
        }
    }
    
    private func warning(_ message: String = "warning",
                         author: String = "sperev/slack",
                         username: String = "tests",
                         completion: @escaping (Any?, Swift.Error?, Int) -> Void) {
        mock() { exp, http, webhook in
            self.log = Log(webhookURL: webhook)
            self.log.level = .verbose
            self.log.username = username
            self.log.author.name = author
            self.log.warning(message) { object, error, code in
                completion(object, error, code)
                http?.stop()
                exp.fulfill()
            }
        }
    }
    
    private func mock(_ action: (XCTestExpectation, HTTPServer?, String) -> Void) {
        let path = "/".appending(Random.string())
        let port = 10000 + Random.number(length: 1000)
        let webhook = "http://localhost:\(port)".appending(path)
        
        let router = Router()
        router.all("/*", middleware: BodyParser())
        router.post(path) { req, res, nex in
            if let dict = req.body?.asJSON?.dictionaryObject {
            } else {
                print("!!! received nil params")
            }
            
            if let key = self.key {
                self.value = req.body?.asJSON?.dictionaryObject?[key]
            }
            try? res.status(.OK).end()
        }
        
        let http = try? HTTPServer.listen(on: port, delegate: router)
        
        let ex = expectation(description: "mokking")
        action(ex, http, webhook)
        waitForExpectations(timeout: 1) { _ in http?.stop() }
    }
}
