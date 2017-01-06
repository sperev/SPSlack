//
//  Request.swift
//  SPSlack
//
//  Created by Sergei Perevoznikov on 30/12/2016.
//
//

import Foundation
import WebRequest

public class Request {
    private var url: URL?
    private var request: WebRequest = WebRequest()
    
    public init(webhookURL: String) {
        url = URL(string: webhookURL)
    }
    
    public func send(message: Message, queue: OperationQueue, completion: @escaping (Any?, Error?, Int) -> Void) {
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: Map.map(message: message), options: .prettyPrinted)
        
        self.request.send(request, queue: queue) { object, error, code in
            completion(object, error, code)
        }
    }
}
