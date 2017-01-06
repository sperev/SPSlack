//
//  Map.swift
//  SPSlack
//
//  Created by Sergei Perevoznikov on 30/12/2016.
//
//

import Foundation

//username: "ghost-bot"
//icon_emoji: ":ghost:"
//text: "BOO!"
//attachments {
//    "fallback": "Required plain-text summary of the attachment.",
//    "color": "#36a64f",
//    "pretext": "Optional text that appears above the attachment block",
//    "author_name": "Bobby Tables",
//    "author_link": "http://flickr.com/bobby/",
//    "author_icon": "http://flickr.com/icons/bobby.jpg",
//    "title": "Slack API Documentation",
//    "title_link": "https://api.slack.com/",
//    "text": "Optional text that appears within the attachment",
//    "fields": [
//    {
//    "title": "Priority",
//    "value": "High",
//    "short": false
//    }
//    ],
//    "image_url": "http://my-website.com/path/to/image.jpg",
//    "thumb_url": "http://example.com/path/to/thumb.png",
//    "footer": "Slack API",
//    "footer_icon": "https://platform.slack-edge.com/img/default_application_icon.png",
//    "ts": 123456789
//}

class Map {
    class func map(message: Message) -> [String: Any] {
        var object: [String: Any] = [:]
        
        if let value = message.username {
            object["username"] = value
        }
        
        if let value = message.text {
            object["text"] = value
        }
        
        if let value = message.icon_emoji {
            object["icon_emoji"] = value
        }
        
        if let attachments = message.attachments  {
            object["attachments"] = map(attachments: attachments)
        }
        
        return object
    }
    
    private class func map(attachments: [Attachment]) -> [Any] {
        var object: [Any] = []
        for attachment in attachments {
            object.append(map(attachment: attachment))
        }
        return object
    }
    
    private class func map(attachment: Attachment) -> [String: Any] {
        var object: [String: Any] = [:]
        object["fallback"] = attachment.fallback
        if let value = attachment.color {
            object["color"] = value
        }
        if let value = attachment.pretext {
            object["pretext"] = value
        }
        if let value = attachment.text {
            object["text"] = value
        }
        
        if let value = attachment.image_url {
            object["image_url"] = value
        }
        
        if let value = attachment.thumb_url {
            object["thumb_url"] = value
        }
        
        if let value = attachment.author?.name {
            object["author_name"] = value
        }
        if let value = attachment.author?.link {
            object["author_link"] = value
        }
        if let value = attachment.author?.icon {
            object["author_icon"] = value
        }
        
        if let value = attachment.title?.title {
            object["title"] = value
        }
        
        if let value = attachment.title?.link {
            object["title_link"] = value
        }
        
        if let value = attachment.fields  {
            object["fields"] = map(fields: value)
        }
        
        if let value = attachment.footer?.footer {
            object["footer"] = value
        }
        
        if let value = attachment.footer?.icon {
            object["footer_icon"] = value
        }
        
        if let value = attachment.footer?.ts {
            object["ts"] = value
        }
        
        return object
    }
    
    private class func map(fields: [Field]) -> [Any] {
        var object: [Any] = []
        for field in fields {
            object.append(map(field: field))
        }
        return object
    }
    
    private class func map(field: Field) -> [String: Any] {
        var object: [String: Any] = [:]
        if let value = field.title {
            object["title"] = value
        }
        if let value = field.value {
            object["value"] = value
        }
        if let value = field.short {
            object["short"] = value
        }
        return object
    }
}
