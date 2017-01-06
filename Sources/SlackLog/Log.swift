//
//  SlackRequestTests.swift
//  SPSlack
//
//  Created by Sergei Perevoznikov on 30/12/2016.
//
//

import Foundation
import Slack
import WebRequest

public enum LogLevel: Int {
    case verbose
    case debug
    case info
    case warning
    case error
    public var color: String {
        switch self {
        case .verbose: return "#F35A00"
        case .debug: return "#009D63"
        case .info: return "#02A6D2"
        case .warning: return "#FBB049"
        case .error: return "#FF1B49"
        }
    }
}

public class Log {
    //private static var shared: Log?
    private static var webhook: String?
    public static var author: String = "sperev/slack"
    public static var level: LogLevel = .verbose
    public static var username: String = "log"
    
    public class func setup(webhookURL: String) {
        webhook = webhookURL
    }
    
    public class func error(_ text: String, completion: @escaping (Any?, Error?, Int) -> Void = { _ in }) {
        guard let webhook = webhook else { return }
        let log = Log(webhookURL: webhook)
        log.author.name = author
        log.level = level
        log.username = username
        log.error(text, completion: completion)
    }
    
    public class func debug(_ text: String, completion: @escaping (Any?, Error?, Int) -> Void = { _ in }) {
        guard let webhook = webhook else { return }
        let log = Log(webhookURL: webhook)
        log.author.name = author
        log.level = level
        log.username = username
        log.debug(text, completion: completion)
    }
    
    public class func info(_ text: String, completion: @escaping (Any?, Error?, Int) -> Void = { _ in }) {
        guard let webhook = webhook else { return }
        let log = Log(webhookURL: webhook)
        log.author.name = author
        log.level = level
        log.username = username
        log.info(text, completion: completion)
    }
    
    public class func warning(_ text: String, completion: @escaping (Any?, Error?, Int) -> Void = { _ in }) {
        guard let webhook = webhook else { return }
        let log = Log(webhookURL: webhook)
        log.author.name = author
        log.level = level
        log.username = username
        log.warning(text, completion: completion)
    }
    
    private let queue = OperationQueue()
    private var request: Slack.Request
    public var author: Author = Author()
    
    public var level: LogLevel = .error
    public var username: String = "slack-log"
    
    public init(webhookURL: String) {
        request = Request(webhookURL: webhookURL)
    }
    
    private func attachment(_ level: LogLevel, author: Author?, text: String) -> Attachment {
        var object = Attachment()
        object.color = level.color
        object.text = text
        object.author = author
        var footer = Footer()
        footer.ts = Int(Date().timeIntervalSince1970)
        object.footer = footer
        return object
    }
    
    public func error(_ text: String,
                      completion: @escaping (Any?, Error?, Int) -> Void = { _ in }) {
        log(.error, text: text, completion: completion)
    }
    
    public func debug(_ text: String,
                      completion: @escaping (Any?, Error?, Int) -> Void = { _ in }) {
        log(.debug, text: text, completion: completion)
    }
    
    public func info(_ text: String,
                     completion: @escaping (Any?, Error?, Int) -> Void = { _ in }) {
        log(.info, text: text, completion: completion)
    }
    
    public func warning(_ text: String,
                        completion: @escaping (Any?, Error?, Int) -> Void = { _ in }) {
        log(.warning, text: text, completion: completion)
    }
    
    private func log(_ level: LogLevel, text: String,
                     completion: @escaping (Any?, Error?, Int) -> Void) {
        if level.rawValue < Log.level.rawValue {
            completion(nil, nil, 0)
            return
        }
        
        var message = Message()
        message.username = username
        message.attachments = [attachment(level, author: author, text: text)]
        
        request.send(message: message, queue: queue) { object, error, code in
            OperationQueue.main.addOperation {
                completion(object, error, code)
            }
        }
    }
}
