//
//  Message.swift
//  SPSlack
//
//  Created by Sergei Perevoznikov on 30/12/2016.
//
//

import Foundation

public struct Message {
    public var username: String? //"ghost-bot"
    public var icon_emoji: String? //":ghost:"
    public var text: String? //"BOO!"
    public var attachments: [Attachment]?
    public init() {}
}
