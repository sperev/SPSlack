//
//  Attachment.swift
//  SPSlack
//
//  Created by Sergei Perevoznikov on 30/12/2016.
//
//

import Foundation

public struct Attachment {
    public var fallback: String  = "summary" //": "Required plain-text summary of the attachment"
    public var color: String? //"#36a64f"
    public var pretext: String? //"Optional text that appears above the attachment block"
    public var author: Author?
    public var title: Title?
    public var text: String? //"Optional text that appears within the attachment"
    public var fields: [Field]?
    public var image_url: String? //"http://my-website.com/path/to/image.jpg"
    public var thumb_url: String? //"http://example.com/path/to/thumb.png"
    public var footer: Footer?
    public init() {}
}
