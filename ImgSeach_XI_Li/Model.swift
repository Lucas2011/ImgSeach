//
//  Model.swift
//  ImgSeach_XI_Li
//
//  Created by Lucas on 7/25/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import UIKit

class Model: NSObject {
    @objc var id:String?
    @objc var secret:String?
    @objc var server:String?
    @objc var farm:NSInteger = 0
    @objc var imgURL:String?

    
//    https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}




